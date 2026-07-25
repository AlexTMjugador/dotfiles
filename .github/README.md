# 🏠 Personal Dotfiles

A collection of hidden, user-specific configuration files stored in my home
directory for applications that follow Unix, Filesystem Hierarchy Standard
(FHS), or XDG Base Directory Specification conventions.

## ⚙️ Purpose

Facilitate environment consistency across computers, and provide a principled
way to backup and version changes to my configuration.

## 📁 Repository layout

Each branch in this repository represents a set of dotfiles that are deployed
and managed together. In most cases, each branch corresponds to a specific
environment. The set of branches may evolve over time as needed without any
notice.

Once an appropriate branch has been selected for a target environment, the
repository is intended to be consumed as a bare repository under `~/.dotfiles`,
with the home directory serving as its worktree. Files in the home directory are
tracked on an opt-in basis, reflecting the reality that home directories often
contain many non-configuration files, as well as deployment-specific
configuration that should not be version-controlled (such as credentials).

Keeping Git conflicts between branches to a minimum is desirable. The
recommended workflow is:

- Base the branch for a target environment on a "parent" branch.
- If necessary, modify the base branch so that it loads configuration from
additional files managed by the child branch.
- Limit the child branch to adding new files.

Readers familiar with dotfile management may recognize that this approach is
based on the techniques described in the following websites:

- <https://wiki.archlinux.org/title/Dotfiles>
- <https://www.atlassian.com/git/tutorials/dotfiles>

## 🚀 Quickstart

Based on the Arch Linux Wiki article linked above:

```sh
git clone --bare https://github.com/AlexTMjugador/dotfiles.git ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
dotfiles config status.showUntrackedFiles no
dotfiles submodule update --init --recursive
```

The `dotfiles` alias can then be used as a drop-in replacement for `git` when
managing the version-controlled dotfiles.
