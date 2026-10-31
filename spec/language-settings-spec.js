describe("language-crystal editing defaults", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    await lumine.packages.activatePackage("language-source");
    await lumine.packages.activatePackage("language-crystal");

    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.crystal"));
    editor.setText("empty?(value)");
    await editor.whenGrammarSettled();
  });
  afterEach(() => editor?.destroy());

  it("selects a complete language identifier without including adjacent syntax", () => {
    const index = editor.getText().indexOf("empty?");
    editor.setCursorBufferPosition(editor.getBuffer().positionForCharacterIndex(index + 2));
    editor.selectWordsContainingCursors();
    expect(editor.getSelectedText()).toBe("empty?");
  });
  it("keeps explicit user word-boundary overrides", () => {
    const options = { scopeSelector: ".source.crystal" };
    try {
      lumine.config.set("editor.nonWordCharacters", "?", options);
      const index = editor.getText().indexOf("empty?");
      editor.setCursorBufferPosition(editor.getBuffer().positionForCharacterIndex(index + 2));
      editor.selectWordsContainingCursors();
      expect(editor.getSelectedText()).not.toBe("empty?");
    } finally {
      lumine.config.unset("editor.nonWordCharacters", options);
    }
  });
});
