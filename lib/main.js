let injectionRegistrations = [];

exports.activate = function () {
  injectionRegistrations.push(
    lumine.grammars.addInjectionPoint("source.crystal", {
      type: "regex",
      language() {
        return "regex";
      },
      content(node) {
        return node.descendantsOfType("literal_content");
      },
      languageScope: null,
    }),
  );

  injectionRegistrations.push(
    lumine.grammars.addInjectionPoint("source.crystal", {
      type: "heredoc_body",
      language(node) {
        return node.lastNamedChild?.type === "heredoc_end"
          ? node.lastNamedChild.text.toLowerCase()
          : null;
      },
      content(node) {
        return node.descendantsOfType("literal_content");
      },
    }),
  );

  for (const type of [
    "macro_def",
    "macro_begin",
    "macro_if",
    "macro_elsif",
    "macro_else",
    "macro_unless",
    "macro_for",
    "macro_verbatim",
  ]) {
    injectionRegistrations.push(
      lumine.grammars.addInjectionPoint("source.crystal", {
        type,
        language() {
          return "crystal";
        },
        content(node) {
          return node.descendantsOfType("expressions")[0] ?? null;
        },
        languageScope: null,
        includeChildren: true,
      }),
    );
  }
};

exports.deactivate = function () {
  for (const registration of injectionRegistrations.splice(0)) registration.dispose();
};
