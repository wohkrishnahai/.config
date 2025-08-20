#! /bin/bash

DIRS=(
	"$HOME/documents"
	"$HOME"
	"$HOME/documents/vault"
	"$HOME/documents/projects"
)

if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(find "${DIRS[@]}" -mindepth 1 -maxdepth 1 -type d | \
		sed "s|^$HOME/||" | \
		fzf-tmux -p 80%,60%)

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0 

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
