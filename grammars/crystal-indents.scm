; A complete inline block keeps its own row level, including ELSE/WHEN
; branches that would otherwise count as extra unmatched opening keywords.
([(annotation_def) (class_def) (module_def) (method_def) (lib_def) (if) (unless) (case) (while) (until) (begin) (select)] @match.next
  (#is? test.startsOnSameRowAs endPosition)
  (#match? @match.next "\\bend$")
  (#set! indent.match startPosition))

; Reindent changes code structure, never the contents of multiline literals
; or the alignment a user chose inside a block comment.
([(string) (regex) (heredoc_body) (comment)] @preserve
  (#is? indent.reindent true)
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))

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

; Abstract methods and foreign function declarations have no body.
(abstract_method_def "def" @_IGNORE_ (#set! capture.final true))
(fun_def "fun" @_IGNORE_
  (#is? test.descendantOfType "lib_def")
  (#set! capture.final true))

; THEN separates the branch header from its body; the branch keyword already
; supplies its indentation.
("then" @_IGNORE_ (#set! capture.final true))

; `#{` is not an indentation delimiter, so its closing brace must not
; cancel an outer list or block on the same row.
(interpolation "}" @_IGNORE_ (#set! capture.final true))

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
