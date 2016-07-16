
ctrlp() {
	</dev/tty vim -c CtrlP
}
zle -N ctrlp

bindkey "^p" ctrlp

