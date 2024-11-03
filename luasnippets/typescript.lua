return {
  s("anf", {
    t("("), i(1, "args"), t(") => "),
    i(0),
  }, { description = "Creates an arrow function" }),

  s("genf", {
    t("function "), i(1, "functionName"), t("<"), i(2, "T"), t(">("), i(3, "params: "), rep(2), t("): "), rep(2), t(" {"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }, { description = "Creates a generic function" }),

  s("typeguard", {
    t("function is"), i(1, "Type"), t("("), i(2, "obj"), t(": any): obj is "), rep(1), t(" {"),
    t({ "", "\treturn " }), i(0),
    t({ "", "}" })
  }, { description = "Creates a type guard function" }),

  s("decorator", {
    t("@"), i(1, "DecoratorName"), t("("), i(2, "params"), t(")"),
    t({ "", "" }), i(0)
  }, { description = "Applies a decorator to a class or method" }),

  s("mapped", {
    t("type "), i(1, "NewType"), t(" = {"),
    t({ "", "\t[Key in keyof " }), i(2, "ExistingType"), t("]: "), i(3, "Type"),
    t({ "", "};" })
  }, { description = "Creates a mapped type" }),

  s("condtype", {
    t("type "), i(1, "TypeName"), t(" = "), i(2, "Condition"), t(" extends "), i(3, "OtherType"), t(" ? "), i(4,
    "TrueType"), t(" : "), i(5, "FalseType"), t(";")
  }, { description = "Defines a conditional type" }),

  s("moduleaug", {
    t("declare module '"), i(1, "moduleName"), t("' {"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }, { description = "Performs module augmentation" }),

  s("idxintf", {
    t("interface "), i(1, "InterfaceName"), t(" {"),
    t({ "", "\t[key: " }), i(2, "KeyType"), t("]: "), i(3, "ValueType"), t(";"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }, { description = "Creates an interface with an index signature" }),

  s("curry", {
    t("const "), i(1, "curriedFunc"), t(" = ("), i(2, "param1: "), i(3, "Type1"), t(") => ("), i(4, "param2: "), i(5,
    "Type2"), t(") => "),
    i(0),
  }, { description = "Creates a curried function" }),

  s("hook", {
    t("function use"), i(1, "HookName"), t("() {"),
    t({ "", "\tconst [state, setState] = React.useState(" }), i(2, "initialState"), t(");"),
    t({ "", "\t" }), i(0),
    t({ "", "\treturn state;" }),
    t({ "", "}" })
  }, { description = "Defines a custom React hook" }),

  s("union", {
    t("type "), i(1, "UnionName"), t(" = "), i(2, "Type1"), t(" | "), i(3, "Type2"), t(";")
  }, { description = "Creates a union type" }),

  s("enum", {
    t("enum "), i(1, "EnumName"), t(" {"),
    t({ "", "\t" }), i(2, "Member1"), t(" = "), i(3, "Value1"), t(","),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }, { description = "Declares an enum" }),

  s("symbol", {
    t("const "), i(1, "sym"), t(" = Symbol('"), i(2, "description"), t("');")
  }, { description = "Creates a unique symbol" }),

  s("tmpltype", {
    t("type "), i(1, "TypeName"), t(" = `"), i(2, "Prefix${"), i(3, "TypeVar"), t("}Suffix`"), t(";")
  }, { description = "Defines a template literal type" }),

  s("keyremap", {
    t("type "), i(1, "RemappedType"), t(" = {"),
    t({ "", "\t[Key in keyof " }), i(2, "OriginalType"), t(" as "), i(3, "NewKey<Key>"), t("]: "), i(4, "ValueType"),
    t({ "", "};" })
  }, { description = "Remaps keys in a mapped type" }),

  s("infer", {
    t("type "), i(1, "ReturnType"), t("<T> = T extends ("), i(2, "args"), t(") => infer R ? R : any;")
  }, { description = "Extracts return types using 'infer'" }),

  s("uniqarr", {
    t("const "), i(1, "uniqueArray"), t(" = Array.from(new Set("), i(2, "array"), t("));"),
  }, { description = "Creates an array with unique values from another array" }),

  s("mapobj", {
    t("const "), i(1, "newArray"), t(" = "), i(2, "array"), t(".map("),
    c(3, {
      sn(nil, { t("("), i(1, "item"), t(") => {"), t({ "", "\t" }), i(0), t({ "", "})" }) }),
      sn(nil, { t("async ("), i(1, "item"), t(") => {"), t({ "", "\t" }), i(0), t({ "", "})" }) }),
    }),
    t(";"),
  }, { description = "Maps over an array of objects" }),

  s("mapkv", {
    t("const "), i(1, "newObject"), t(" = Object.fromEntries("),
    t({ "", "\tObject.entries(" }), i(2, "originalObject"), t(").map((["),
    i(3, "key"), t(", "), i(4, "value"), t("]) => ["),
    rep(3), t(", "), i(0), t("])"),
    t({ "", ");" })
  }, { description = "Maps over an object's key-value pairs" }),

  s("getkeyst", {
    t("const "), i(1, "keys"), t(": string[] = Object.keys("), i(2, "object"), t(");"),
  }, { description = "Retrieves keys from an object" }),

  s("getvaluest", {
    t("const "), i(1, "values"), t(": "), i(2, "ValueType"), t("[] = Object.values("), i(3, "object"), t(");"),
  }, { description = "Retrieves values from an object" }),

  s("clg", {
    t('console.log("'), i(1, "variable"), t(': ", '), rep(1), t(');'),
  }, { description = "Console log variable with label" }),

}
