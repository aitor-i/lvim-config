return {
  s("anf", {
    t("("), i(1, "args"), t(") => "),
    i(0),
  }, { description = "Creates an arrow function" }),

  s("genf", {
    t("function "), i(1, "functionName"), t("<"), i(2, "T"), t(">("), i(3, "params: "), rep(2), t("): "), rep(2), t(" {"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }),

  s("typeguard", {
    t("function is"), i(1, "Type"), t("("), i(2, "obj"), t(": any): obj is "), rep(1), t(" {"),
    t({ "", "\treturn " }), i(0),
    t({ "", "}" })
  }),

  s("decorator", {
    t("@"), i(1, "DecoratorName"), t("("), i(2, "params"), t(")"),
    t({ "", "" }), i(0)
  }),

  s("mapped", {
    t("type "), i(1, "NewType"), t(" = {"),
    t({ "", "\t[Key in keyof " }), i(2, "ExistingType"), t("]: "), i(3, "Type"),
    t({ "", "};" })
  }),
  s("condtype", {
    t("type "), i(1, "TypeName"), t(" = "), i(2, "Condition"), t(" extends "), i(3, "OtherType"), t(" ? "), i(4,
    "TrueType"), t(" : "), i(5, "FalseType"), t(";")
  }),
  s("moduleaug", {
    t("declare module '"), i(1, "moduleName"), t("' {"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }),
  s("idxintf", {
    t("interface "), i(1, "InterfaceName"), t(" {"),
    t({ "", "\t[key: " }), i(2, "KeyType"), t("]: "), i(3, "ValueType"), t(";"),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }),
  s("curry", {
    t("const "), i(1, "curriedFunc"), t(" = ("), i(2, "param1: "), i(3, "Type1"), t(") => ("), i(4, "param2: "), i(5,
    "Type2"), t(") => "),
    i(0),
  }),
  s("hook", {
    t("function use"), i(1, "HookName"), t("() {"),
    t({ "", "\tconst [state, setState] = React.useState(" }), i(2, "initialState"), t(");"),
    t({ "", "\t" }), i(0),
    t({ "", "\treturn state;" }),
    t({ "", "}" })
  }),
  s("union", {
    t("type "), i(1, "UnionName"), t(" = "), i(2, "Type1"), t(" | "), i(3, "Type2"), t(";")
  }),
  s("enum", {
    t("enum "), i(1, "EnumName"), t(" {"),
    t({ "", "\t" }), i(2, "Member1"), t(" = "), i(3, "Value1"), t(","),
    t({ "", "\t" }), i(0),
    t({ "", "}" })
  }),
  s("symbol", {
    t("const "), i(1, "sym"), t(" = Symbol('"), i(2, "description"), t("');")
  }),
  s("tmpltype", {
    t("type "), i(1, "TypeName"), t(" = `"), i(2, "Prefix${"), i(3, "TypeVar"), t("}Suffix`"), t(";")
  }),
  s("keyremap", {
    t("type "), i(1, "RemappedType"), t(" = {"),
    t({ "", "\t[Key in keyof " }), i(2, "OriginalType"), t(" as "), i(3, "NewKey<Key>"), t("]: "), i(4, "ValueType"),
    t({ "", "};" })
  }),
  s("infer", {
    t("type "), i(1, "ReturnType"), t("<T> = T extends ("), i(2, "args"), t(") => infer R ? R : any;")
  }),
  s("uniqarr", {
    t("const "), i(1, "uniqueArray"), t(" = Array.from(new Set("), i(2, "array"), t("));"),
  }),

  s("mapobj", {
    t("const "), i(1, "newArray"), t(" = "), i(2, "array"), t(".map("),
    c(3, {
      sn(nil, { t("("), i(1, "item"), t(") => {"), t({ "", "\t" }), i(0), t({ "", "})" }) }),
      sn(nil, { t("async ("), i(1, "item"), t(") => {"), t({ "", "\t" }), i(0), t({ "", "})" }) }),
    }),
    t(";"),
  }),
  s("mapkv", {
    t("const "), i(1, "newObject"), t(" = Object.fromEntries("),
    t({ "", "\tObject.entries(" }), i(2, "originalObject"), t(").map((["),
    i(3, "key"), t(", "), i(4, "value"), t("]) => ["),
    rep(3), t(", "), i(0), t("])"),
    t({ "", ");" })
  }),

  s("getkeyst", {
    t("const "), i(1, "keys"), t(": string[] = Object.keys("), i(2, "object"), t(");"),
  }),

  s("getvaluest", {
    t("const "), i(1, "values"), t(": "), i(2, "ValueType"), t("[] = Object.values("), i(3, "object"), t(");"),
  }),

}
