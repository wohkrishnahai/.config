autoload -U colors && colors
PS1="%{$fg[blue]%}%~%{$fg[red]%} %{$reset_color%}$%b "

## History in cache directory
SAVEHIST=1000
HISTSIZE=1000

finder() {
	open .
}
zle -N finder
bindkey '^f' finder

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Basic auto/tab complete:
autoload -U compinit && compinit
autoload -U colors && colors
zmodload zsh/complist

_comp_options+=(globdots)		# Include hidden files.

export PATH="/opt/homebrew/bin:$PATH"
source <(fzf --zsh)
# Load zsh-syntax-highlighting; should be last.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias vim=nvim
alias vi="nvim"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
