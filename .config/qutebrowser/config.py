
# ────── 📦 基础设置 ────── #

config.load_autoconfig(False)
config.source("keymaps.py")

c.scrolling.smooth = True
c.scrolling.bar = "when-searching"

c.fonts.default_size = "14pt"
c.content.headers.accept_language = "zh-CN;q=0.9,en-US;q=0.8"

# ✅ 最新浏览器伪装（避免 B 站、ChatGPT 报浏览器版本低）
c.content.headers.user_agent = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
)

c.url.default_page = "https://bing.com"
c.url.start_pages = "https://bing.com"
c.url.searchengines = {
    "DEFAULT": "https://bing.com/search?q={}"
}

# ────── ⌨ Hint 设置 ────── #

c.hints.chars = "asdfghjklzxcvbnm"
c.hints.padding = {"top": 1, "bottom": 1, "left": 5, "right": 3}
c.hints.border = "none"

# ────── 📊 状态栏 / 标签栏 ────── #

c.statusbar.show = "in-mode"
c.statusbar.widgets = ["search_match", "text:|", "url", "text:|", "scroll"]
c.statusbar.padding = {"top": 2, "bottom": 2, "left": 0, "right": 5}

c.tabs.show = "multiple"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 10, "right": 10}

# ────── 🎨 主题：Catppuccin Mocha ────── #

c.colors.statusbar.normal.bg = "#1e1e2e"
c.colors.statusbar.normal.fg = "#cdd6f4"
c.colors.statusbar.insert.bg = "#a6e3a1"
c.colors.statusbar.insert.fg = "#1e1e2e"

c.colors.tabs.selected.odd.bg = "#89b4fa"
c.colors.tabs.selected.odd.fg = "#1e1e2e"
c.colors.tabs.selected.even.bg = "#89b4fa"
c.colors.tabs.selected.even.fg = "#1e1e2e"
c.colors.tabs.odd.bg = "#313244"
c.colors.tabs.odd.fg = "#a6adc8"
c.colors.tabs.even.bg = "#313244"
c.colors.tabs.even.fg = "#a6adc8"
c.colors.tabs.bar.bg = "#181825"

c.colors.hints.bg = "#f5c2e7"
c.colors.hints.fg = "#1e1e2e"
c.colors.hints.match.fg = "#f38ba8"

c.colors.prompts.bg = "#1e1e2e"
c.colors.prompts.fg = "#cdd6f4"
c.colors.prompts.border = "1px solid #585b70"
c.colors.prompts.selected.bg = "#89b4fa"
c.colors.prompts.selected.fg = "#1e1e2e"

c.colors.completion.scrollbar.bg = "#1e1e2e"
c.colors.completion.scrollbar.fg = "#a6adc8"

# ────── 🖋 字体（建议使用 Nerd Font）────── #

c.fonts.statusbar = "10pt JetBrainsMono Nerd Font"
c.fonts.tabs.selected = "bold 10pt JetBrainsMono Nerd Font"
c.fonts.tabs.unselected = "10pt JetBrainsMono Nerd Font"
c.fonts.prompts = "10pt JetBrainsMono Nerd Font"

# ────── 🌙 暗色网页模式（默认开启，可快捷关闭）────── #

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.threshold.foreground = 150
c.colors.webpage.darkmode.threshold.background = 205
c.colors.webpage.preferred_color_scheme = "dark"

