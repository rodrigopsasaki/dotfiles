# ── [Core PATH] ──
# .zshenv runs for ALL shell types: interactive, login, scripts, IDEs.
# This is the single source of truth for Homebrew and essential PATH entries.

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH="$PATH:/Users/rodrigosasaki/Library/Application Support/JetBrains/Toolbox/scripts"
