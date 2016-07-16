#-skip

function _gulp {
	local -a opts args

	local version="false"
	local require="false"
	local gulpfile="false"
	local needgulpfile="false"
	local gulpfilepath="gulpfile.js"
	local _cwd="false"
	local tasks="false"
	local tasks_simple="false"
	local color="false"
	local nocolor="false"
	local silent="false"

	local curr="${words[CURRENT-1]}"

	if [[ "$curr" == "--gulpfile" ]]; then
		_path_files
		return
	fi

	while [[ "${#words}" > 1 ]]; do
		if [[ "$needgulpfile" == "true" ]]; then
			gulpfilepath="${words[1]}"
			needgulpfile="false"
			shift words
			continue
		fi
		case ${words[1]} in
			-v | --version)
				version="true"
				;;
			--require)
				require="true"
				;;
			--gulpfile)
				gulpfile="true"
				needgulpfile="true"
				;;
			--cwd)
				_cwd="true"
				;;
			-T)
				tasks="true"
				;;
			--tasks)
				tasks="true"
				;;
			--tasks-simple)
				tasks_simple="true"
				;;
			--color)
				color="true"
				;;
			--no-color)
				nocolor="true"
				;;
			--silent)
				silent="true"
				;;
		esac
		shift words
	done
	if [[ "$version" == "false" ]]; then
		opts=($opts "-v:print version")
		opts=($opts "--version:print version")
	fi
	if [[ "$require" == "false" ]]; then
		opts=($opts "--require:will require a module before running the gulpfile")
	fi
	if [[ "$gulpfile" == "false" ]]; then
		opts=($opts "--gulpfile:will manually set path of gulpfile")
	fi
	if [[ "$_cwd" == "false" ]]; then
		opts=($opts "--cwd:will manually set the CWD")
	fi
	if [[ "$tasks" == "false" ]]; then
		opts=($opts "--tasks:will display the task dependency tree for the loaded gulpfile")
	fi
	if [[ "$tasks_simple" == "false" ]]; then
		opts=($opts "--tasks-simple:will display a plaintext list of tasks for the loaded gulpfile")
	fi
	if [[ "$color" == "false" ]]; then
		opts=($opts "--color:will force gulp and gulp plugins to display colors even when no color support is detected")
	fi
	if [[ "$nocolor" == "false" ]]; then
		opts=($opts "--no-color:will force gulp and gulp plugins to not display colors even when color support is detected")
	fi
	if [[ "$silent" == "false" ]]; then
		opts=($opts "--silent:will disable all gulp logging")
	fi

	if [[ -f "$gulpfilepath" ]]; then
		if [[ "$_GULP_LAST_CWD" != "$(pwd)" ]]; then
			args=($(gulp --tasks-simple --gulpfile "$gulpfilepath"))
			if [[ "${#args}" != "0" ]]; then
				_GULP_LAST_CWD="$(pwd)"
				_GULP_CACHE=($args)
			fi
		else
			args=($_GULP_CACHE)
		fi
	fi
	local -a empty
	_describe 'options' opts -- empty
	_describe 'tasks' empty -- args
}

function _gulp_clean { #-expose
	unset _GULP_LAST_CWD
	unset _GULP_CACHE
}

compdef _gulp gulp

