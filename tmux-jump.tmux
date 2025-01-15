#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR"/scripts/utils.sh

case $(get_tmux_option "@use_bind_key_notes_in_plugins" "No") in
    Yes | yes | True | true)
        note="-N 'plugin: tmux-jump trigger'"
        ;;
    *) note="" ;;
esac

key="$(get_tmux_option "@jump-key" "j")"
action="run-shell -b '$CURRENT_DIR/scripts/tmux-jump.sh'"

# log_it "cmd: $TMUX_BIN bind-key \"$key\" \"$action\""
eval "$TMUX_BIN" bind-key "$note" "$key" "$action"
