
function attach_usage { #-skip
	local bin="attach"
	(
		echo "Usage: $bin <container> [cmd ...]"
	) > /dev/stderr
	return 2
}

function attach {
	local container="$1"

	if [[ "$container" == "" ]]; then
		attach_usage "$0"
		return $?
	fi
	shift
	local cmd=$@
	if [[ "$cmd" == "" ]]; then
		if [[ -r "$HOME/.attach/$container" ]]; then
			cmd="$(cat $HOME/.attach/$container)"
		else
			cmd="bash"
		fi
	else
		docker exec -it "$container" $@
		return $?
	fi
	docker exec -it "$container" $cmd
	return $?
}

function _attach { #-skip
	local -a opts args

	if [[ "$CURRENT" == "1" ]] || [[ "$CURRENT" == "2" ]]; then
		args=($(docker ps --format="{{.Names}}"))
		_describe 'values' opts -- args
	elif [[ "$CURRENT" == "3" ]]; then
		shift words
		CURRENT=$[CURRENT-1]
		args=(
			'(-)1:command: _command_names -e'                                           
			'*::arguments: _normal'
		)
		_arguments -s -S $args
	else
		shift words
		CURRENT=$[CURRENT-1]
		args=(
			'(-)1:command: _command_names -e'                                           
			'*::arguments: _normal'
		)
		_arguments -s -S $args
	fi
}

compdef _attach attach

