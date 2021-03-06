# https://unix.stackexchange.com/questions/294592/change-the-key-that-show-previous-command-lines-in-ksh
#https://man.openbsd.org/ksh#Emacs_editing_mode
set -o emacs
function KEYBD_trap {
  case ${.sh.edchar} in
    $'\e'[[O]A) .sh.edchar=$'\e>';;
    $'\e'[[O]B) .sh.edchar=$'\e<';;
  esac
}
#trap KEYBD_trap KEYBD

# https://unix.stackexchange.com/questions/42753/korn-shell-end-pgup-pgdown-and-delete-key-not-working
# toget possible shortcuts: stty -a
keybd_trap () {
  case ${.sh.edchar} in
    $'\e[1~') .sh.edchar=$'\001';; # Home = beginning-of-line
    $'\e[4~') .sh.edchar=$'\005';; # End = end-of-line
    $'\e[5~') .sh.edchar=$'\e>';; # PgUp = history-previous
    $'\e[6~') .sh.edchar=$'\e<';; # PgDn = history-next
    $'\e[3~') .sh.edchar=$'\004';; # Delete = delete-char
    $'\e\e[D') .sh.edchar=$'\eW';; # alt+Delete = backward-kill-word = werase = ^W
    $'\e\e[C') .sh.edchar=$'\ef';; # alt+right = forward-word = M-f
  esac
}
trap keybd_trap KEYBD
set -o emacs

. ${DIREXPLOIT}/.aliasrc

