
### 基础选项 ###
setopt HIST_IGNORE_ALL_DUPS         # 避免历史记录重复
bindkey -v                          # 使用 vim 模式
WORDCHARS=${WORDCHARS//[\/]}       # 优化单词边界识别

### Zim 初始化 ###
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
source ${ZIM_HOME}/init.zsh

### 模块配置 ###
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

### 历史搜索绑定（substring-search） ###
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
bindkey -M vicmd k history-substring-search-up
bindkey -M vicmd j history-substring-search-down

### 环境变量 ###
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin:$HOME/.dwm"
export DEEPSEEK_API_KEY="sk-2b741a7ab6844cba9a2f575d3a4dbbe8"

### 启动插件 ###
[[ -f ~/fzf.sh ]] && source ~/fzf.sh
eval "$(thefuck --alias fuck)"

### 常用 alias 与函数 ###
alias mount-win="~/mount-win.sh"
alias pc='proxychains4'

# yazi 目录跳转集成
function y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
  rm -f -- "$tmp"
}

### 终端标题自动更新（兼容 tmux/screen） ###
autoload -Uz add-zsh-hook

function xterm_title_precmd() {
  print -Pn -- '\e]2;%~\a'
  [[ "$TERM" == screen* ]] && print -Pn -- '\e_\005{g}%n\005{-}@%m %~\e\\'
}

function xterm_title_preexec() {
  print -Pn -- '\e]2;%~ %# ' && print -n -- "${(q)1}\a"
  [[ "$TERM" == screen* ]] && {
    print -Pn -- '\e_\005{g}%n\005{-}@%m %~ %# '
    print -n -- "${(q)1}\e\\"
  }
}

case "$TERM" in
  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*)
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
    ;;
esac

### 启动 fastfetch ###
[[ $TERM != "dumb" && -x "$(command -v fastfetch)" ]] && fastfetch

