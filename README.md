# language-crystal

Crystal language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-crystal](https://github.com/crystal-lang-tools/tree-sitter-crystal).
- **Syntax highlighting**: highlights declarations, types, literals, macros, operators, and variables.
- **Editing**: provides parse-tree folding and indentation for Crystal's `end`-delimited blocks.
- **Navigation**: exposes types, methods, macros, constants, calls, and local bindings from Tree-sitter queries.
- **Embedded syntax**: parses regex literals, recognized heredocs, and macro bodies through Tree-sitter injections.

## Installation

To install `language-crystal` search for it in the Install pane of the Lumine settings, or run the command `lumine --install lumine-code/language-crystal`.

## Injections

- Static Tree-sitter injections highlight URLs with `language-hyperlink`.
- Static Tree-sitter injections highlight comment markers with `language-todo`.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
