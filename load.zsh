
ZROOT="$HOME/.zprezto"

function load_github() {
	local name=$1

	if [[ "$name" == "" ]]; then
		echo "Usage: $0 <plugin name>" > /dev/stderr
		return 2
	fi
	if [[ ! -d "$ZROOT/plugins/github.com/$name" ]]; then
		git clone "git@github.com:$name.git" "$ZROOT/plugins/github.com/$name" || return 1
		load_github $@ || return $?
		return 0
	fi
	shift
	fpath=("$ZROOT/plugins/github.com/$name" $fpath)
	local files=($@)
	if [[ $#files == 0 ]] || [[ $files == "()" ]]; then
		local default_file=$(basename $name).zsh
		if [[ -f "$ZROOT/plugins/github.com/$name/$default_file" ]]; then
			source "$ZROOT/plugins/github.com/$name/$default_file"
			return 0
		fi
	else
		for file in $files; do
			source "$ZROOT/plugins/github.com/$name/$file"
		done
	fi
}

function reload_comp() {
	if [[ "$ZDOTDIR" == ""  ]]; then
		rm -f ~/.zcompdump; compinit
	else
		rm -f $ZDOTDIR/.zcompdump; compinit
	fi
}

alias load=load_github

