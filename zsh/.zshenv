# ── [Core PATH] ──
# .zshenv runs for ALL shell types: interactive, login, scripts, IDEs.
# This is the single source of truth for Homebrew and essential PATH entries.
# Each entry is guarded so a machine without Homebrew/Docker/Toolbox starts clean.

[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PATH"
[[ -d /Applications/Docker.app ]] && export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
  export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
