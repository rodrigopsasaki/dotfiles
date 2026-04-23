# Rodrigo's Dotfiles

Modular, macOS-first dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each tool lives in its own directory. `stow <tool>` activates it; `stow -D <tool>` removes it.

## Getting started

```bash
git clone https://github.com/rodrigopsasaki/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow git zsh nvim mise gh fzf gnupg ghostty
```

`.stowrc` sets `--target=~`, so everything lands in your home directory.

## Prerequisites

Install with Homebrew:

```bash
brew install stow gh mise nvim fzf eza bat git-delta jq gnupg pinentry-mac
brew install --cask ghostty
```

And bootstrap zsh:

```bash
# oh-my-zsh + plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
```

After `stow zsh`, run `p10k configure` to generate `~/.p10k.zsh`.

## Packages

| Package   | Target                         | What it is                                            |
| --------- | ------------------------------ | ----------------------------------------------------- |
| `git`     | `~/.config/git/`               | Aliases, delta diffs, scoped identities via `includeIf` |
| `zsh`     | `~/.zsh/`, `~/.zshrc`, `~/.zshenv` | Modular zsh config sourced from `~/.zsh/*.zsh`     |
| `nvim`    | `~/.config/nvim/`              | Neovim config (Lua)                                   |
| `mise`    | `~/.config/mise/`              | Language runtime versions                             |
| `gh`      | `~/.config/gh/config.yml`      | GitHub CLI (auth lives in gitignored `hosts.yml`)     |
| `fzf`     | `~/.config/fzf/`               | Preview script                                        |
| `gnupg`   | `~/.gnupg/gpg-agent.conf`      | GPG agent with `pinentry-mac`, ssh-support            |
| `ghostty` | `~/.config/ghostty/`           | Terminal config                                       |

## Git identity scoping

The tracked `git/.config/git/config` has no personal identity. Identity is loaded via `includeIf`:

```ini
[includeIf "gitdir:~/"]
  path = ~/.config/git/private/config.local   # default (personal)

[includeIf "gitdir:~/dev/sfr3/**"]
  path = ~/.config/git/sfr3/config.local      # work override
```

Scoped `config.local` files live under `~/.config/git/<scope>/` and are gitignored (pattern `git/.config/git/*/` in `.gitignore`). Create them locally with your name, email, and signing key.

## Machine-private config

Anything that shouldn't be public — work tokens, work-specific aliases, company CLI init — lives in a sibling private repo at `~/.dotfiles-private`. Its `zsh-private` package stows to `~/.zsh-private/`, which the public `.zshrc` sources if present.

```bash
git clone git@github.com:rodrigopsasaki/dotfiles-private ~/.dotfiles-private
cd ~/.dotfiles-private && stow zsh-private
```

## Philosophy

- **Modular** — one tool per package, opt-in via `stow`.
- **Safe** — no secrets, no identity, no tokens in the public repo.
- **Explicit** — no wrapper scripts, no magic bootstrapping.
