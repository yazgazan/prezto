
expand-or-complete-with-dots() {
	color red
	echo -n "..."
	color reset
	zle expand-or-complete
	zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

