
function color_usage {
	local bin="color"
	(
		echo "Usage: $bin <color> [style = regular]"
		echo "       $bin reset"
		echo "       $bin colors"
		echo "       $bin styles"
		echo "       $bin help"
	) > /dev/stderr
	return 2
}

function color_colors {
	echo "\t- black
	- red
	- green
	- yellow
	- blue
	- purple
	- cyan
	- white"
}

function color_styles {
	echo "\t- regular
	- bold
	- underline
	- background"
}

function color {
	local c="$1"
	local s="$2"
	local stxt=""
	local ctxt=""
	if [[ "$c" == "" ]]; then
		color_usage "$0"
		return $?
	fi
	if [[ "$s" == "" ]]; then
		s="regular"
	fi
	if [[ "$c" == "help" ]]; then
		color_usage "$0"
		return 0
	fi
	if [[ "$c" == "colors" ]]; then
		color_colors
		return 0
	fi
	if [[ "$c" == "styles" ]]; then
		color_styles
		return 0
	fi
	if [[ "$c" == "reset" ]]; then
		echo -n '\e[0m'
		return 0
	fi
	if [[ "$s" == "regular" ]]; then
		stxt='\e[0;'
	elif [[ "$s" == "bold" ]]; then
		stxt='\e[1;'
	elif [[ "$s" == "underline" ]]; then
		stxt='\e[4;'
	elif [[ "$s" == "background" ]]; then
		stxt='\e[4'
	else
		color_usage "$0"
		return $?
	fi
	if [[ "$c" == "black" ]]; then
		ctxt='30m'
	elif [[ "$c" == "red" ]]; then
		ctxt='31m'
	elif [[ "$c" == "green" ]]; then
		ctxt='32m'
	elif [[ "$c" == "yellow" ]]; then
		ctxt='33m'
	elif [[ "$c" == "blue" ]]; then
		ctxt='34m'
	elif [[ "$c" == "purple" ]]; then
		ctxt='35m'
	elif [[ "$c" == "cyan" ]]; then
		ctxt='36m'
	elif [[ "$c" == "white" ]]; then
		ctxt='37m'
	else
		color_usage "$0"
		return $?
	fi
	txt="$stxt$ctxt"
	echo -n "$txt"
}

function _color {
	local -a opts args

	colors=("black" "red" "green" "yellow" "blue" "purple" "cyan" "white")
	styles=("regular" "underline" "bold" "background")

	if [[ "$CURRENT" == "1" ]] || [[ "$CURRENT" == "2" ]]; then
		args=($colors)
		opts=("reset" "colors" "styles" "help")
	elif [[ "$CURRENT" == "3" ]]; then
		if [[ "$w" == "reset" ]] || [[ "$w" == "colors" ]] || [[ "$w" == "styles" ]] || [[ "$w" == "help" ]]; then
			return
		fi
		args=($styles)
	fi
	_describe 'values' opts -- args
}

compdef _color color

