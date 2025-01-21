#!/usr/bin/env bash

BASE_PATH_TJ="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v ruby >/dev/null; then
    # If dependency ruby not found, flag this issue, display error, then abort
    touch "$BASE_PATH_TJ"/ruby_not_found
fi

source "$BASE_PATH_TJ"/scripts/utils.sh


case $(get_tmux_option "@use_bind_key_notes_in_plugins" "No") in
    Yes | yes | True | true)
        note="-N 'plugin: tmux-jump trigger'"
        ;;
    *) note="" ;;
esac

key="$(get_tmux_option "@jump-key" "j")"
action="run-shell -b '$BASE_PATH_TJ/scripts/tmux-jump.sh'"

# log_it "cmd: $TMUX_BIN bind-key \"$key\" \"$action\""
eval "$TMUX_BIN" bind-key "$note" "$key" "$action"
