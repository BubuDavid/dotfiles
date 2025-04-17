#!/usr/bin/env zsh

tmux attach -t $(tmux ls -F "#S" | fzf)
