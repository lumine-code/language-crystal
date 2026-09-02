; Adapted from crystal-lang-tools/tree-sitter-crystal at 50ca9e6f (MIT).

; Keywords

[
  "alias"
  "annotation"
  "asm"
  "begin"
  "break"
  "case"
  "do"
  "end"
  "ensure"
  "extend"
  "in"
  "include"
  "next"
  "of"
  "select"
  "then"
  "verbatim"
  "when"
] @keyword.control.crystal

[
  "def"
  "fun"
  "macro"
] @storage.type.function.crystal

[
  "class"
  "enum"
  "lib"
  "module"
  "struct"
  "type"
  "union"
] @storage.type.crystal

"require" @keyword.control.import.crystal

[
  "return"
  "yield"
] @keyword.control.return.crystal

[
  "if"
  "else"
  "elsif"
  "unless"
] @keyword.control.conditional.crystal

(conditional
  [
    "?"
    ":"
  ] @keyword.operator.ternary.crystal)

[
  "for"
  "until"
  "while"
] @keyword.control.loop.crystal

"rescue" @keyword.control.exception.crystal

[
  (private)
  (protected)
  "abstract"
] @storage.modifier.crystal

; Definitions and types

(class_def
  name: [(constant) (generic_type)] @entity.name.type.class.crystal)

(module_def
  name: [(constant) (generic_type)] @entity.name.type.module.crystal)

(struct_def
  name: (constant) @entity.name.type.struct.crystal)

(enum_def
  name: (constant) @entity.name.type.enum.crystal)

(lib_def
  name: (constant) @entity.name.type.module.crystal)

(annotation_def
  name: (constant) @entity.name.type.annotation.crystal)

(method_def
  name: [(identifier) (operator)] @entity.name.function.method.crystal)

(macro_def
  name: [(identifier) (operator)] @entity.name.function.macro.crystal)

(abstract_method_def
  name: [(identifier) (operator)] @entity.name.function.method.abstract.crystal)

(fun_def
  name: [(identifier) (constant)] @entity.name.function.crystal
  real_name: [(identifier) (constant) (string)]? @entity.name.function.foreign.crystal)

[
  (constant)
  (generic_instance_type)
  (generic_type)
] @support.class.crystal

[
  (class_type)
  (named_tuple_type)
  (pointer_type)
  (proc_type)
  (static_array_type)
  (tuple_type)
] @support.storage.type.crystal

(nilable_constant
  "?" @storage.modifier.nullable.crystal)

(nilable_type
  "?" @storage.modifier.nullable.crystal)

(union_type
  "|" @keyword.operator.type-union.crystal)

(annotation
  (constant) @entity.other.attribute-name.crystal)

; Literals

(pseudo_constant) @constant.language.crystal
(nil) @constant.language.nil.crystal

[
  (true)
  (false)
] @constant.language.boolean.crystal

(integer) @constant.numeric.integer.crystal
(float) @constant.numeric.float.crystal

(string) @string.quoted.double.crystal

(string
  "\"" @punctuation.definition.string.begin.crystal
  (#is? test.first true))

(string
  "\"" @punctuation.definition.string.end.crystal
  (#is? test.last true))

(string
  (escape_sequence) @constant.character.escape.crystal)

(symbol) @constant.other.symbol.crystal

(symbol
  [":" ":\""] @punctuation.definition.symbol.begin.crystal
  (#is? test.first true))

(symbol
  "\"" @punctuation.definition.symbol.end.crystal
  (#is? test.last true))

(symbol
  (escape_sequence) @constant.character.escape.crystal)

(command) @string.interpolated.command.crystal

(command
  "`" @punctuation.definition.string.begin.crystal
  (#is? test.first true))

(command
  "`" @punctuation.definition.string.end.crystal
  (#is? test.last true))

(command
  (escape_sequence) @constant.character.escape.crystal)

(regex) @string.regexp.crystal

(regex
  "/" @punctuation.definition.regexp.begin.crystal
  (#is? test.first true))

(regex
  "/" @punctuation.definition.regexp.end.crystal
  (#is? test.last true))

(regex_modifier) @storage.modifier.regexp.crystal

(heredoc_body) @string.unquoted.heredoc.crystal

[
  (heredoc_start)
  (heredoc_end)
] @entity.name.label.heredoc.crystal

(char) @constant.character.crystal

(char
  "'" @punctuation.definition.character.begin.crystal
  (#is? test.first true))

(char
  "'" @punctuation.definition.character.end.crystal
  (#is? test.last true))

(char
  (escape_sequence) @constant.character.escape.crystal)

(interpolation
  "#{" @punctuation.section.embedded.begin.crystal
  "}" @punctuation.section.embedded.end.crystal) @meta.embedded.line.interpolation.crystal

; Comments

(comment) @comment.line.number-sign.crystal

((comment) @punctuation.definition.comment.crystal
  (#set! adjust.endAfterFirstMatchOf "^#"))

; Variables, parameters, and calls

(param
  name: (_) @variable.parameter.function.crystal)

(splat_param
  name: (_) @variable.parameter.function.splat.crystal)

(double_splat_param
  name: (_) @variable.parameter.function.double-splat.crystal)

(block_param
  name: (_) @variable.parameter.function.block.crystal)

(fun_param
  name: (_) @variable.parameter.function.crystal)

(rescue
  variable: (identifier) @variable.parameter.exception.crystal)

(macro_var
  name: (identifier) @variable.other.macro.crystal)

(class_var) @variable.other.readwrite.class.crystal
(instance_var) @variable.other.readwrite.instance.crystal
(global_var) @variable.other.readwrite.global.crystal

(underscore) @variable.language.discard.crystal
(self) @variable.language.self.crystal

(assign
  lhs: (identifier) @variable.other.assignment.crystal)

(op_assign
  lhs: (identifier) @variable.other.assignment.crystal)

(named_tuple
  (named_expr
    name: (identifier) @entity.other.attribute-name.crystal))

(argument_list
  (named_expr
    name: (identifier) @variable.parameter.function.crystal))

(named_type
  name: (identifier) @entity.other.attribute-name.crystal)

(call
  method: (identifier) @support.other.function.crystal)

; Operators and punctuation

[
  "="
  "=>"
  "->"
  "&"
  "*"
  "**"
  (operator)
] @keyword.operator.crystal

"(" @punctuation.definition.group.begin.bracket.round.crystal
")" @punctuation.definition.group.end.bracket.round.crystal
"[" @punctuation.definition.array.begin.bracket.square.crystal
"@[" @punctuation.definition.annotation.begin.bracket.square.crystal
"]" @punctuation.definition.array.end.bracket.square.crystal
"{" @punctuation.definition.block.begin.bracket.curly.crystal
"}" @punctuation.definition.block.end.bracket.curly.crystal

"{{" @punctuation.section.embedded.begin.crystal
"}}" @punctuation.section.embedded.end.crystal
"{%" @punctuation.section.embedded.begin.crystal
"%}" @punctuation.section.embedded.end.crystal

(index_call
  method: (operator) @keyword.operator.index.crystal
  ["]" "]?"] @punctuation.definition.index.end.bracket.square.crystal)

(block
  "|" @punctuation.separator.parameters.crystal)

"," @punctuation.separator.comma.crystal
";" @punctuation.terminator.statement.crystal
"." @punctuation.separator.dot.crystal
":" @punctuation.separator.colon.crystal
