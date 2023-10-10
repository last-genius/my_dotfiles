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

For use with CMake, activate this [option](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html)
to generate a `compile_commands.json` file, automatically picked up by the language server.
```
# add option in CMakeLists.txt
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# save file in the main project folder from the build directory
ln -s ~/.../project/build/compile_commands.json ~/.../project/compile_commands.json
```

Install rust language server with [these instructions](https://rust-analyzer.github.io/manual.html#vimneovim)

## `i3` config

My [i3 config](i3/config) and [i3status-rs setup](i3/config.toml).
Some of the basic hotkeys, startup applications, nice
status bar.

Just install `i3-gaps` and `i3status-rust` and drop the `i3` config into `~/.config/i3/`,
`i3status` config into `~/.config/i3status-rust/`.

## `zsh` config

My [`.zshrc`](zsh/.zshrc) file with several aliases, plugins, and a fuzzy searcher.

Install `zsh` and set it up as a default shell, drop `.zshrc` into your home directory.
