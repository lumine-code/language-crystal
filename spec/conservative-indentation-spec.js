describe("Conservative crystal indentation", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-crystal");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.crystal"));
    editor.update({ tabLength: 4, softTabs: true });
    await editor.whenGrammarSettled();
  });

  afterEach(() => editor?.destroy());

  for (const [name, source, row, columns] of [
    ["an outer array beside an inline branch", "values = [if ready; 1; else; 2; end,\n]", 0, 4],
    ["a real block after an inline block", "if first; work; end; if second\nend", 0, 4],
    ["a balanced array containing an inline branch", "values = [if ready; 1; else; 2; end]", 0, 0],
    ["an abstract declaration", "abstract def value", 0, 0],
    ["a foreign function declaration", "lib LibC\n    fun puts(str : UInt8*) : Int32\nend", 1, 4],
    ["a regular method header", "def value\nend", 0, 4],
    ["a postfix modifier", "work if ready", 0, 0],
    ["a literal and comment", 'value = "if class do" # end', 0, 0],
  ]) {
    it(`keeps the intended level after ${name}`, async () => {
      editor.setText(source);
      await editor.whenGrammarSettled();
      editor.setCursorBufferPosition([row, Infinity]);
      editor.insertText("\n", { autoIndent: true, autoIndentNewline: true });
      await editor.whenGrammarSettled();
      expect(editor.lineTextForBufferRow(row + 1)).toBe(" ".repeat(columns));
      expect(editor.getCursorBufferPosition().column).toBe(columns);
    });
  }

  it("dedents a closing delimiter only when it is typed at the start of a row", async () => {
    editor.setText("values = [" + "\n    ");
    await editor.whenGrammarSettled();
    editor.setCursorBufferPosition([1, Infinity]);
    editor.insertText("]", { autoIndent: true, autoDecreaseIndent: true });
    await editor.whenGrammarSettled();
    expect(editor.lineTextForBufferRow(1)).toBe("]");
  });

  it("preserves multiline literal contents during explicit reindent", async () => {
    const source = 'text = "first\n\tkeep this tab\n  keep these spaces"\n';
    editor.setText(source);
    await editor.whenGrammarSettled();
    editor.getBuffer().clearUndoStack();
    editor.autoIndentBufferRows(0, editor.getLastBufferRow() - 1);
    await editor.whenGrammarSettled();
    expect(editor.getText()).toBe(source);
    editor.autoIndentBufferRows(0, editor.getLastBufferRow() - 1);
    expect(editor.getText()).toBe(source);
  });

  it("does not add a level after a complete inline branch", async () => {
    for (const source of ["if ready; work; else; other; end", "case value; when 1; work; end"]) {
      editor.setText(source);
      await editor.whenGrammarSettled();
      editor.setCursorBufferPosition([0, Infinity]);
      editor.insertText("\n", { autoIndent: true, autoIndentNewline: true });
      await editor.whenGrammarSettled();
      expect(editor.lineTextForBufferRow(1)).toBe("");
    }
  });
});
