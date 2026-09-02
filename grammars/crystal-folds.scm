; Adapted from crystal-lang-tools/tree-sitter-crystal at 50ca9e6f (MIT).

[
  (annotation_def)
  (begin)
  (block)
  (c_struct_def)
  (case)
  (class_def)
  (else)
  (enum_def)
  (fun_def)
  (if)
  (lib_def)
  (method_def)
  (macro_begin)
  (macro_def)
  (macro_for)
  (macro_if)
  (macro_unless)
  (module_def)
  (rescue)
  (select)
  (struct_def)
  (union_def)
  (unless)
  (until)
  (when)
  (while)
] @fold

[
  (array)
  (array_like)
  (hash)
  (hash_like)
  (named_tuple)
  (tuple)
] @fold

((comment) @fold
  (#set! fold.endAt endPosition))
