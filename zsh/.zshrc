export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

plugins=(git wd docker zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zstyle :prompt:pure:git:branch color yellow
zstyle :prompt:pure:execution_time color magenta
zstyle ':completion:*' menu select

zplug load

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

ZVM_CURSOR_STYLE_ENABLED=true

# Shell Completions
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# Tool Initializations

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Zoxide
eval "$(zoxide init zsh)"

function __zoxide_hook() {
  local dir
  dir=$(git rev-parse --show-toplevel 2>/dev/null) || dir=$(__zoxide_pwd)
  \command zoxide add -- "$dir"
}

eval "$(fzf --zsh)"

# FZF Configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}

_fzf_compgen_path_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}

# TMUX Session
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -i -H | gum filter --limit 1 --fuzzy --no-sort --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# Aliases
alias lg='lazygit'
