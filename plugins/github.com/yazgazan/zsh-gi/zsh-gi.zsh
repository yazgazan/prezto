#!/usr/bin/env zsh

function gi {
		=curl --silent "https://www.gitignore.io/api/$@" ;
}

if [[ "$(type compdef | =grep 'not found')" == "" ]]; then
	function _gi { #-skip
		local -a opts args

		if [[ ! -f "$HOME/.zprezto/gi.list" ]]; then
			gi list | sed -E s'/,/ /g' > "$HOME/.zprezto/gi.list"
		fi

		if [[ "$CURRENT" != 2 ]]; then
			return
		fi
		opts=($(cat "$HOME/.zprezto/gi.list"))

		_describe 'values' opts -- args
	}

	compdef _gi gi
	return
fi

