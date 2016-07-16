
path=(
	"$HOME/bin"
	"$HOME/.nodebrew/current/bin"
	"~/Library/Android/sdk/tools"
	"~/Library/Android/sdk/platform-tools"
	"/usr/local/bin"
	"/usr/local/go/bin"
	"/Users/yazou/gocode/bin"
	"/Users/yazou/Library/Android/sdk/platform-tools"
	"/Users/yazou/Library/Android/sdk/tools"
	"$HOME/.rvm/bin"
	"$HOME/.rvm/rubies/ruby-2.3.0/bin/"
	"/Library/Frameworks/Python.framework/Versions/3.5/bin"
	$path
)

fpath=(
	"$HOME/.zprezto/completion"
	$fpath
)

compinit

