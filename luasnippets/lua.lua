return {
  s("foo", { t("Expands to bar") }),
  s("nsp", {
    t("namespace "),
    f(_G.calculate_csharp_namespace, {}),
    t({ "", "{", "\t" }),
    i(0),
    t({ "", "}" }),
  }),

}
