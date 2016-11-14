
function hist_git {
	local ref=$1
	local head=$(git rev-parse HEAD)
	if [[ $# -gt 0 ]]; then
		shift
	fi

	git log --pretty=oneline --right-only --no-merges --abbrev-commit $@ $ref...$head
	return $?
}

function _hist_git {
	local -a opts args

	if [[ "$CURRENT" == "1" ]] || [[ "$CURRENT" == "2" ]]; then
		args=(
			$(git tag --list)
			$(git branch | sed -E s'/^[\* ]+//')
		)
	fi
	_describe 'values' opts -- args
}

compdef _hist_git hist_git
