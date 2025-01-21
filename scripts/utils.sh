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

get_digits_from_string() {
    # this is used to get "clean" integer version number. Examples:
    # `tmux 1.9` => `19`
    # `1.9a`     => `19`
    local string="$1"
    local only_digits no_leading_zero

    only_digits="$(echo "$string" | tr -dC '[:digit:]')"
    no_leading_zero=${only_digits#0}
    echo "$no_leading_zero"
}

get_tmux_vers() {
    #
    #  Variables provided:
    #   tmux_vers - version of tmux used
    #
    tmux_vers="$($TMUX_BIN -V | cut -d' ' -f2)"

    # Filter out devel prefix and release candidate suffix
    case "$tmux_vers" in
    next-*)
        # Remove "next-" prefix
        tmux_vers="${tmux_vers#next-}"
        ;;
    *-rc*)
        # Remove "-rcX" suffix, otherwise the number would mess up version
        # 3.4-rc2 would be read as 342
        tmux_vers="${tmux_vers%-rc*}"
        ;;
    *) ;;
    esac
}

tmux_vers_compare() {
    #
    #  This returns true if v_comp <= v_ref
    #  If only one param is given it is compared vs version of running tmux
    #
    local v_comp="$1"
    local v_ref="${2:-$tmux_vers}"
    local i_comp i_ref


    i_comp=$(get_digits_from_string "$v_comp")
    i_ref=$(get_digits_from_string "$v_ref")

    [[ "$i_comp" -le "$i_ref" ]]
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

[[ -z "$BASE_PATH_TJ" ]] && {
    $TMUX_BIN display "ERROR: BASE_PATH_TJ undefined in: $0"
}

f_ruby_not_found="$BASE_PATH_TJ"/ruby_not_found

get_tmux_vers

if [[ -f "$f_ruby_not_found" ]]; then
    #  If it has been installed, remove error hint and continue
    if command -v ruby >/dev/null; then
        rm -f "$f_ruby_not_found"
    else
        err_msg="DEPENDENCY: plugin tmux-jump requires ruby"
        if tmux_vers_compare 3.2; then
            $TMUX_BIN display-popup -h 3 printf " $err_msg"
        else
            $TMUX_BIN display "$err_msg"
        fi
    fi
fi
