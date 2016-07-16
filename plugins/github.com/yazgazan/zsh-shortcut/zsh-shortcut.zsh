
function shortcut {
	local name=$1

	echo "$name=$PWD" >> $ZROOT/dirconf.zsh
	echo "$name=$PWD" | source /dev/stdin
}

function _shortcut {
	local -a opts
	local args=($(echo $PWD | sed -E s'/\// /g'))

	_describe "folder names" opts -- args
}

compdef _shortcut shortcut

