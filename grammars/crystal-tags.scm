; Adapted from the upstream Aerial query at 50ca9e6f (MIT).

(module_def
  name: (constant) @name) @definition.module

(lib_def
  name: (constant) @name) @definition.module

(class_def
  name: [(constant) (generic_type)] @name) @definition.class

(struct_def
  name: (constant) @name) @definition.class

(enum_def
  name: (constant) @name) @definition.class

(union_def
  name: (constant) @name) @definition.class

(annotation_def
  name: (constant) @name) @definition.class

(method_def
  name: [(identifier) (operator)] @name) @definition.method

(macro_def
  name: [(identifier) (operator)] @name) @definition.function

(fun_def
  name: [(identifier) (constant)] @name) @definition.function

(const_assign
  lhs: (constant) @name) @definition.constant

(alias
  name: (constant) @name) @definition.class

(call
  method: (identifier) @name) @reference.call
