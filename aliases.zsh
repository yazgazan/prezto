
alias ls='ls -GhF'
alias lg='ls -go'
alias ll='ls -l'
alias la='ll -A'
alias rm='rm -rvf'
alias cp='cp -rvf'
alias mv='mv -vf'

alias co='git co'
alias ci='git ci'
alias add='git add'
alias pull='git pull'
alias push='git push'
alias publish='git publish'
alias br='git brs'
alias stash='git stash'
alias st='git st'
alias merge='git merge'
alias pr='git pull-request -b development'

alias reload="source $HOME/.zshrc"
alias rn-dev-menu="adb shell input keyevent 82"
alias vinstall='vim +PluginInstall +qall'
alias ips=$'ifconfig | \\grep inet | grep -v :: | sed -E "s/[ \t]+/ /" | cut -d" " -f3'

alias grep='grep -sIi --color=yes'
alias updatedb='sudo /usr/libexec/locate.updatedb'

export ANDROID_HOME=~/Library/Android/sdk
export GOPATH=$HOME/gocode
export EDITOR="vim"
export PAGER="less"
export LESS='-i -R'

alias rnand='react-native run-android'
alias rnios4s='react-native run-ios --simulator "iPhone 4s"'
alias rnios5='react-native run-ios --simulator "iPhone 5"'
alias rnios5s='react-native run-ios --simulator "iPhone 5s"'
alias rnios='react-native run-ios'

alias glint="find . -type d -not -path '*/\\.*' -exec golint {} \;"
alias hist=hist_git
alias pull-request='git pull-request -b development'

alias do-create="docker-machine create --driver digitalocean --digitalocean-access-token $(cat $HOME/.dotoken)"

function valias() {
	name="$1"
	shift
	cmd="$@"

	alias $name="echo '>' '$cmd' && echo && $cmd"
}

valias fmt 'find . -type d -exec go fmt {} \;'

function dash() {
	open "dash://$@"
}

eval "$(hub alias -s)"
