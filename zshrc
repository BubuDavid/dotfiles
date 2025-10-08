# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

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

bindkey -s ^f^f "tmux-sessionizer^M"
bindkey -s ^f^t "tmux-sessionizer --channel \"tmux ls\"^M"

export EDITOR='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. "$HOME/.local/bin/env"

export PATH="/opt/node-current/bin:$PATH" # Custom symlink to my custom node installation

# Eza aliases:
alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
ff() {
    export selected=$(find ./ -not -path '*/.*' 2>/dev/null | fzf)
    echo "selected = ${selected}"
}
