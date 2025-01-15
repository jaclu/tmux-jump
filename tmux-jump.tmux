#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/scripts/utils.sh
#  -N "Jump to pane location in copy mode"
$TMUX_BIN bind-key $(get_tmux_option "@jump-key" "j") run-shell -b "$CURRENT_DIR/scripts/tmux-jump.sh"
