
# Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.3.app"
if [ -d "$GHC_DOT_APP" ]; then
	export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
else
	echo 'Warning: ghc not installed' > /dev/stderr
fi

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
	"/Applications/calibre.app/Contents/console.app/Contents/MacOS"
	$path
)

fpath=(
	"$HOME/.zprezto/completion"
	$fpath
)

compinit

export GITHUB_TOKEN="****"
export REACT_EDITOR=/Users/yazou/bin/vim

