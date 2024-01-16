return {
  -- h1 tag snippet
  s("h1", {
    t("<h1>"), i(1), t("</h1>"),
  }),

  -- h2 tag snippet
  s("h2", {
    t("<h2>"), i(1), t("</h2>"),
  }),

  -- h3 tag snippet
  s("h3", {
    t("<h3>"), i(1), t("</h3>"),
  }),

  -- h4 tag snippet
  s("h4", {
    t("<h4>"), i(1), t("</h4>"),
  }),
  -- p tag snippet
  s("p", {
    t("<p>"), i(1), t("</p>"),
  }),

  -- div tag snippet
  s("div", {
    t("<div>"), i(1), t("</div>"),
  }),

  -- span tag snippet
  s("span", {
    t("<span>"), i(1), t("</span>"),
  }),

  -- ul tag snippet
  s("ul", {
    t("<ul>"), i(1), t("</ul>"),
  }),

  -- li tag snippet
  s("li", {
    t("<li>"), i(1), t("</li>"),
  }),

  -- a tag snippet
  s("a", {
    t('<a href="'), i(1), t('">'), i(2), t("</a>"),
  }),

  -- img tag snippet
  s("img", {
    t('<img src="'), i(1), t('" alt="'), i(2), t('"/>'),
  }),

  -- form tag snippet
  s("form", {
    t("<form>"), i(1), t("</form>"),
  }),

  -- input tag snippet
  s("input", {
    t('<input type="'), i(1, "text"), t('" name="'), i(2), t('"/>'),
  }),

  -- button tag snippet
  s("button", {
    t("<button>"), i(1), t("</button>"),
  }),

  -- table tag snippet
  s("table", {
    t("<table>"), i(1), t("</table>"),
  }),

  -- tr tag snippet
  s("tr", {
    t("<tr>"), i(1), t("</tr>"),
  }),

  -- td tag snippet
  s("td", {
    t("<td>"), i(1), t("</td>"),
  }),

  -- th tag snippet
  s("th", {
    t("<th>"), i(1), t("</th>"),
  }),

  -- section tag snippet
  s("section", {
    t("<section>"), i(1), t("</section>"),
  }),

  -- header tag snippet
  s("header", {
    t("<header>"), i(1), t("</header>"),
  }),

  -- footer tag snippet
  s("footer", {
    t("<footer>"), i(1), t("</footer>"),
  }),

  -- nav tag snippet
  s("nav", {
    t("<nav>"), i(1), t("</nav>"),
  }),

  -- Add more snippets for other tags as needed
}
