[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '~/.config/fzf/preview.sh {}'"

