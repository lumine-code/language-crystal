; Crystal follows Ruby-style end-delimited blocks. Modifier forms must be
; claimed first so their trailing keywords do not indent the next row.

(modifier_if "if" @_IGNORE_
  (#set! capture.final true))
(modifier_unless "unless" @_IGNORE_
  (#set! capture.final true))
(modifier_rescue "rescue" @_IGNORE_
  (#set! capture.final true))
(modifier_ensure "ensure" @_IGNORE_
  (#set! capture.final true))

[
  "annotation"
  "begin"
  "case"
  "class"
  "def"
  "do"
  "else"
  "elsif"
  "ensure"
  "enum"
  "fun"
  "if"
  "in"
  "lib"
  "macro"
  "module"
  "rescue"
  "select"
  "struct"
  "then"
  "union"
  "unless"
  "until"
  "when"
  "while"
  "{"
  "["
  "("
] @indent

[
  "end"
  "else"
  "elsif"
  "ensure"
  "in"
  "rescue"
  "when"
  "}"
  "]"
  ")"
] @dedent

(comment) @ignore
