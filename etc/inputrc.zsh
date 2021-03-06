# http//abhisanoujam.blogspot.fr/2009/06/bash-command-line-editing-custom.html
# http//www.faqs.org/docs/bashman/bashref_90.html#SEC97

# bind -p | egrep "del|backward|end|begining" to find out the current associations.
# HOWTO find key sequences
# 1) CTRL+V then CHAR to show the real code, then replace ^[ by \e, then rebind it.
# 2) od -c, type the key, then Enter, then Ctrl+D (033 = \e)
# 3) Linux rlwrap rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl -a /bin/ksh
# 4) AIX rlwrap   rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl /bin/ksh

# This file controls the behaviour of line input editing for
# programs that use the Gnu Readline library.  Existing programs
# include FTP, Bash, Gdb, rlwrap...
#
# You can re-read the inputrc file with C-x C-r.
# Lines beginning with '#' are comments.
#

set editing-mode emacs
set completion-ignore-case
#set show-all-if-ambiguous
set visible-stats
set output-meta

# Enable 8bit input
set meta-flag On 
set input-meta On

#$if mode=emacs
bindkey "\C-x\C-r" re-read-init-file

bindkey "\C-f" forward-word
bindkey "\C-b" backward-word
#bindkey "\C-a" beginning-of-line
bindkey "\C-e" end-of-line
bindkey "\C-u" unix-line-discard
bindkey "\C-w" unix-word-rubout
bindkey "\C-x\C-u" undo

## output from bind -p (some are genuine, some are for use under screen)
## ALT+ARROWS
bindkey "\e\eOD" backward-word
bindkey "\e\eOC" forward-word

## HOME/END
## for xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
## for linux console
bindkey "\e[1~" beginning-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[F" end-of-line
bindkey "^[" kill-word


#$endif

#$if term=dumb
## HOME for AIX rlwrap
#bindkey "~" beginning-of-line
#$endif
