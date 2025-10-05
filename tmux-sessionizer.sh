#!/usr/bin/env zsh

# Capture the selected directory
selected=$(find ~/work ~/dev ~/ ~/learning ~/vid ~/.config /mnt/c/Users/david/.glzr -mindepth 1 -maxdepth 2 -type d -not -path '*/.*' -print | sort -u | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# If no tmux session is running, start a new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # Start a new session
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if [[ -z $TMUX ]]; then
    # Try to attach, or start a new session with activation
    if tmux has-session -t=$selected_name 2> /dev/null; then
        tmux attach-session -t $selected_name
    else
        tmux new-session -s $selected_name -c $selected
    fi
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    # Create new detached session
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

