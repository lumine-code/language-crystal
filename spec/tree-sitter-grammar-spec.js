const { Point } = require("lumine");
const fs = require("fs");
const path = require("path");

const highlightsPath = path.join(__dirname, "..", "grammars", "crystal-highlights.scm");

// Asserts the scopes the grammar actually produces, using the fixture beside
// this file. `runGrammarTests` reads `<- scope` and `^ scope` assertions out of
// the fixture's own comments, so the fixture is the readable spec.
//
// A fixture whose assertions never run still reports green, so break one
// expected scope and confirm this fails before trusting it.

describe("Crystal Tree-sitter grammar", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-crystal");
  });

  afterEach(() => editor?.destroy());

  async function highlightCaptures(options) {
    const groups = await editor.getGrammarQueryCaptureGroups("highlightsQuery", options);
    return groups.find(({ grammar }) => grammar === editor.getGrammar())?.captures ?? [];
  }

  it("tokenizes the fixture", async () => {
    await runGrammarTests(path.join(__dirname, "fixtures", "sample.cr"), /#/);
  });

  it("distinguishes opening and closing literal delimiters, including empty literals", async () => {
    editor = await lumine.workspace.open("delimiters.cr");
    editor.setText("text = \"\"; pattern = //; char = 'x'; command = ``");
    await editor.getBuffer().getLanguageMode().ready;

    const scopesAt = (text, occurrence = 0) => {
      const line = editor.lineTextForBufferRow(0);
      let column = -1;
      for (let index = 0; index <= occurrence; index++) column = line.indexOf(text, column + 1);
      return editor.scopeDescriptorForBufferPosition([0, column]).getScopesArray();
    };

    expect(scopesAt('"', 0)).toContain("punctuation.definition.string.begin.crystal");
    expect(scopesAt('"', 0)).not.toContain("punctuation.definition.string.end.crystal");
    expect(scopesAt('"', 1)).toContain("punctuation.definition.string.end.crystal");
    expect(scopesAt('"', 1)).not.toContain("punctuation.definition.string.begin.crystal");
    expect(scopesAt("/", 0)).toContain("punctuation.definition.regexp.begin.crystal");
    expect(scopesAt("/", 0)).not.toContain("punctuation.definition.regexp.end.crystal");
    expect(scopesAt("/", 1)).toContain("punctuation.definition.regexp.end.crystal");
    expect(scopesAt("/", 1)).not.toContain("punctuation.definition.regexp.begin.crystal");
    expect(scopesAt("'", 0)).toContain("punctuation.definition.character.begin.crystal");
    expect(scopesAt("'", 1)).toContain("punctuation.definition.character.end.crystal");
    expect(scopesAt("`", 0)).toContain("punctuation.definition.string.begin.crystal");
    expect(scopesAt("`", 0)).not.toContain("punctuation.definition.string.end.crystal");
    expect(scopesAt("`", 1)).toContain("punctuation.definition.string.end.crystal");
    expect(scopesAt("`", 1)).not.toContain("punctuation.definition.string.begin.crystal");
  });

  it("keeps raw captures bounded on literal-heavy CRLF input", async () => {
    editor = await lumine.workspace.open("capture-budget.cr");
    editor.setText(
      Array.from(
        { length: 1000 },
        (_, index) =>
          `value_${index} = "text"; pattern_${index} = /item/; char_${index} = 'x' # generated`,
      ).join("\r\n"),
    );
    await editor.getBuffer().getLanguageMode().ready;

    expect((await highlightCaptures()).length).toBeLessThanOrEqual(28000);
    expect(
      (
        await highlightCaptures({
          startPosition: new Point(400, 0),
          endPosition: new Point(406, 0),
        })
      ).length,
    ).toBeLessThanOrEqual(170);
  });

  it("keeps named arguments local inside a 6000-row argument list", async () => {
    expect(fs.readFileSync(highlightsPath, "utf8")).not.toContain("(argument_list\n  (named_expr");

    editor = await lumine.workspace.open("large-arguments.cr");
    editor.setText(
      ["call(", ...Array.from({ length: 6000 }, (_, index) => `  key_${index}: value,`), ")"].join(
        "\r\n",
      ),
    );
    await editor.getBuffer().getLanguageMode().ready;
    const captures = await highlightCaptures({
      startPosition: new Point(3000, 0),
      endPosition: new Point(3006, 0),
    });

    expect(captures.length).toBeLessThanOrEqual(64);
    expect(
      captures.every(
        (capture) =>
          capture.node.startPosition.row >= 3000 && capture.node.startPosition.row < 3006,
      ),
    ).toBe(true);
  });

  it("keeps command escapes local inside a 6000-row command literal", async () => {
    expect(fs.readFileSync(highlightsPath, "utf8")).not.toContain("(command\n  (escape_sequence)");

    editor = await lumine.workspace.open("large-command.cr");
    const lines = ["value = `"];
    for (let index = 0; index < 6000; index++) lines.push("  \\n");
    lines.push("`");
    editor.setText(lines.join("\r\n"));
    await editor.getBuffer().getLanguageMode().ready;
    const captures = await highlightCaptures({
      startPosition: new Point(3000, 0),
      endPosition: new Point(3006, 0),
    });
    const escapes = captures.filter(
      (capture) => capture.name === "constant.character.escape.crystal",
    );

    expect(escapes.length).toBe(6);
    expect(
      escapes.every(
        (capture) =>
          capture.node.startPosition.row >= 3000 && capture.node.startPosition.row < 3006,
      ),
    ).toBe(true);
  });
});
