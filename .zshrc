export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Keybinds
bindkey '^j' backward-char
bindkey '^k' forward-char
bindkey '^h' backward-word
bindkey '^l' forward-word

bindkey '^D' delete-char-or-list

bindkey '^X^E' edit-command-line
bindkey '^@' clear-screen

export EDITOR='nvim'

eval "$(tv init zsh)"
