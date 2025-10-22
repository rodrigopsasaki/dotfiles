# ── [Powerlevel10k Instant Prompt Guard for Cursor] ──
if [[ "$TERM_PROGRAM" == "vscode" || -n "$VSCODE_PID" ]]; then
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
fi

# ── [Powerlevel10k Instant Prompt] ──
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── [Oh My Zsh Core] ──
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ── [Powerlevel10k Config] ──
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── [Modular Zsh Config] ──
for file in ~/.zsh/*.zsh; do
  source "$file"
done


