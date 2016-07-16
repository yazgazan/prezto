
function rgrep() {
	local folder="$1"
	local needle="$2"

	if [[ "$needle" == "" ]]; then
		needle="$1"
		folder="."
	fi
	grep -n -r "$needle" "$folder"
}

