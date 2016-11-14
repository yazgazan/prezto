
function _d_list {
	typeset | \grep -aE $'^[^ ]+\=\'?\/.+$' | while read vardef; do
		local varname="$(echo $vardef | cut -d'=' -f1)"
		local _path="$(eval 'echo $'$varname)"

		[[ -d $_path ]] && echo "$varname:$_path"
	done
}

function d {
	local varname=$1

	if [[ $varname == "" ]]; then
		(
			echo "Usage: $0 <variable name>"
			echo
			echo "Available shortcuts:"
		) > /dev/stderr
		_d_list | sed -E 's/^/- /;s/:.+$//'
		return 2
	fi
	local _path="$(eval 'echo $'$varname)"
	if [[ $_path == "" ]]; then
		echo "Error: variable not found or empty" > /dev/stderr
		return 1
	fi

	cd $_path
	return $?
}
if [[ $(alias d) != "" ]]; then
	unalias d
fi

function _d {
	local -a opts
	local args=($(_d_list))

	_describe 'variables' opts -- args
}

compdef _d d

