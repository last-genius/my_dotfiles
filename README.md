**This repository contains most of my dotfiles with detailed comments and instructions on setting them up.**

*I try to update this along with my config, but it might take some time for me to describe new changes.*

Since I currently use an `i3` system with `zsh` as my shell and `nvim` as my editor, these are the most important configs here.

## `nvim` config

A huge `nvim` config [over here](nvim/init.vim) along with [coc.vim settings](nvim/coc-settings.json).

Install `nvim` and drop these into `~/.config/nvim/`

Install [`vim-plug`](https://github.com/junegunn/vim-plug) or another plugin 
manager (that'd require modifying the plugin sections with that manager calls).

Use this command whenever you update plugins in your config:
```
nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins
```

Install rust language server with [these instructions](https://rust-analyzer.github.io/manual.html#vimneovim)

## `i3` config

My [i3 config](i3/config) and [i3blocks setup](i3/i3blocks.conf) with a bunch 
of separate scripts. Some of the basic hotkeys, startup applications, nice
status bar.

Just install `i3-gaps` and `i3blocks` and drop the `i3` folder into `~/.config/i3/`.

## `zsh` config

My [`.zshrc`](zsh/.zshrc) file with several aliases, plugins, and a fuzzy searcher.

Install `zsh` and set it up as a default shell, drop `.zshrc` into your home directory.
