#!/usr/bin/env bash

log_it() {
    echo "$1" >> "$HOME"/tmp/tmux-jump.log
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/scripts/utils.sh

log_it "tmux-jump tmux[$TMUX_BIN]"
key="$(get_tmux_option "@jump-key" "j")"
log_it "key[$key]"

case $(get_tmux_option "@use_bind_key_notes_in_plugins" "No") in
    Yes | yes | True | true)
	note="-N 'plugin: tmux-jump trigger'"
	;;
    *) note="" ;;
esac
log_it "note:[$note]"

action="run-shell -b '$CURRENT_DIR/scripts/tmux-jump.sh'"
log_it "action:[$action]"

# log_it "cmd: $TMUX_BIN bind-key \"$key\" \"$action\""
eval $TMUX_BIN bind-key "$note" "$key" "$action"
