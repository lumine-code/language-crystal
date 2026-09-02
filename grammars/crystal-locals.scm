[
  (method_def)
  (macro_def)
  (fun_def)
  (block)
] @local.scope

(param
  name: (identifier) @local.definition)

(splat_param
  name: (identifier) @local.definition)

(double_splat_param
  name: (identifier) @local.definition)

(block_param
  name: (identifier) @local.definition)

(fun_param
  name: (identifier) @local.definition)

(rescue
  variable: (identifier) @local.definition)

(assign
  lhs: (identifier) @local.definition)

(op_assign
  lhs: (identifier) @local.definition)

(identifier) @local.reference
