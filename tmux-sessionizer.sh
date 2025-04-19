#!/usr/bin/env zsh

# Default value for channel
channel="custom dirs"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --channel=*)
            channel="${1#*=}"
            shift
            ;;
        --channel)
            if [[ -n "$2" && "$2" != --* ]]; then
                channel="$2"
                shift 2
            else
                echo "Error: Missing value for --channel" >&2
                exit 1
            fi
            ;;
        *)
            selected="$1"
            shift
            ;;
    esac
done

# If no directory was selected as a positional argument, use tv with the specified channel
if [[ -z $selected ]]; then
    selected=$(tv "$channel")
fi

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

