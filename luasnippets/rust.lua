return {
  s("afn", {
    t("async fn "),
    f(function(_, snip) return snip.env.TM_FILENAME_BASE end, {}),
    t("("),
    i(1, "args"),
    t(") -> "),
    i(2, "ReturnType"),
    t({ " {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s("fnr", {
    t("fn "),
    f(function(_, snip) return snip.env.TM_FILENAME_BASE end, {}),
    t("("),
    i(1, "args"),
    t(") -> "),
    i(2, "ReturnType"),
    t({ " {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
}
