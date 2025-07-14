### ─── PATH 设置 ─────────────────────────────────────────────────────
# export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.dwm:$PATH"

### ─── Oh My Zsh 初始化 ──────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

### ─── Shell 环境设置 ────────────────────────────────────────────────
export EDITOR='nvim'
export DEEPSEEK_API_KEY="sk-2b741a7ab6844cba9a2f575d3a4dbbe8"
# 历史记录配置
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# 快捷键绑定（方向键搜索历史）
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

### ─── 常用 alias 与函数 ─────────────────────────────────────────────
alias mount-win="~/mount-win.sh"
alias pc='proxychains4'

# yazi 的 cd 保持函数
function y() {
	local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
	rm -f -- "$tmp"
}

# thefuck 命令修复工具
eval "$(thefuck --alias fuck)"

### ─── 终端标题设置 ──────────────────────────────────────────────────
autoload -Uz add-zsh-hook

function xterm_title_precmd() {
	print -Pn -- '\e]2;%~\a'
	[[ "$TERM" == screen* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec() {
	print -Pn -- '\e]2;%~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == screen* ]] && {
		print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# '
		print -n -- "${(q)1}\e\\"
	}
}

case "$TERM" in
	Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*)
		add-zsh-hook -Uz precmd xterm_title_precmd
		add-zsh-hook -Uz preexec xterm_title_preexec
		;;
esac

### ─── 插件加载 ──────────────────────────────────────────────────────
# 插件路径统一检查，避免文件不存在报错
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] &&
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# 高亮样式配置
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF7B7B'
ZSH_HIGHLIGHT_STYLES[command]='fg=#8DFF7B'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#ED80FF'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#78ECFF'
ZSH_HIGHLIGHT_STYLES[path]='fg=#78ECFF'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#F5FF7D'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#FFD37F'

### ─── 启动 fastfetch（非 dumb 终端） ───────────────────────────────
[[ $TERM != "dumb" && -x "$(command -v fastfetch)" ]] && fastfetch

