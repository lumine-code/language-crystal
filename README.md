# language-crystal

Crystal language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-crystal](https://github.com/crystal-lang-tools/tree-sitter-crystal).
- **Syntax highlighting**: highlights declarations, types, literals, macros, operators, and variables.
- **Editing**: provides parse-tree folding and indentation for Crystal's `end`-delimited blocks.
- **Navigation**: exposes types, methods, macros, constants, calls, and local bindings from Tree-sitter queries.
- **Embedded syntax**: parses regex literals, recognized heredocs, and macro bodies through Tree-sitter injections.

## Installation

To install `language-crystal` search for _language-crystal_ in the Install pane of the Lumine settings or run `lumine --install lumine-code/language-crystal`.

## Services

- **hyperlink.injection** (`^1.0.0`): consumed to highlight URLs inside Crystal comments as clickable links.
- **todo.injection** (`^1.0.0`): consumed to highlight `TODO`-style markers inside comments.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
