**This repository contains most of my dotfiles with detailed comments and instructions on setting them up.**

*I try to update this along with my config, but it might take some time for me to describe new changes.*

Since I currently use an `i3` system with `zsh` as my shell and `nvim` as my editor, these are the most important configs here.
I have also modified some of the `nvim` plugins to better suit my workflow, more on this below.

#### Contents:
1. [`nvim`](#nvim-config)
1. [`i3`](#i3-config)
1. [`zsh`](#zsh-config)

## `nvim` config

A huge `nvim` config [over here](nvim/init.vim) along with [coc.vim settings]().

Install `nvim` and drop these into `~/.config/nvim/`

## `i3` config

My [i3 config](i3/config) and [i3blocks setup](i3/i3blocks.conf) with a bunch 
of separate scripts. Some of the basic hotkeys, startup applications, nice
status bar.

Just install `i3-gaps` and `i3blocks` and drop the `i3` folder into `~/.config/i3/`.

## `zsh` config

My [`.zshrc`](zsh/.zshrc) file with several aliases, plugins, and a fuzzy searcher.

Install `zsh` and set it up as a default shell, drop `.zshrc` into your home directory.
