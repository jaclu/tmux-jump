#!/usr/bin/env bash

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value

    option_value=$($TMUX_BIN show-option -gqv "$option")
    if [[ -z $option_value ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

#
#  I use an env var TMUX_BIN to point at the used tmux, defined in my
#  tmux.conf, in order to pick the version matching the server running,
#  or when the tmux bin is in fact tmate :)
#  If not found, it is set to whatever is in PATH, so should have no negative
#  impact. In all calls to tmux I use $TMUX_BIN instead in the rest of this
#  plugin.
#
[[ -z "$TMUX_BIN" ]] && TMUX_BIN="tmux"

[[ -z "$BASE_PATH_TJ" ]] && $TMUX_BIN display "ERROR: BASE_PATH_TJ undefined in: $0"


f_ruby_not_found="$BASE_PATH_TJ"/ruby_not_found

if [[ -f "$f_ruby_not_found" ]]; then
    #  If it has been installed, remove error hint and continue
    if command -v ruby >/dev/null; then
        rm -f "$f_ruby_not_found"
    else
        $TMUX_BIN display "ERROR: tmux-jump requires ruby"
    fi
fi
