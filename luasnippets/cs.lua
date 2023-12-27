return {
  s("nsp", {
    t("namespace "),
    f(_G.calculate_csharp_namespace, {}),
    t({ "", "{", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s("css", {
    t("public class "),
    f(function(_, snip) return snip.env.TM_FILENAME_BASE end, {}),
    t({ "", "{", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
}
