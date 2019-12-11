export EDITOR="nvim"

export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PATH=$PY_USER_BIN:$PATH

export PATH="$PATH:~/go/bin"
export PATH="$PATH:~/bin"

# ls on entering a directory
function cd {
	builtin cd "$@" && ls -a --color=auto
}

oldFind=$(which find)
function find() {
	$oldFind $@ -prune -o -name ".git" -prune -o -name "vendor"
}


# PS1 config
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //g' | \
	sed 's/feature/f/g' | \
	sed 's/master/m/g' | \
	sed 's/develop/d/g' | \
	cut -c-10
}

parse_username() {
	whoami | cut -c-1
}

parse_reponame() {
	basename "$(git rev-parse --show-toplevel 2> /dev/null)"
}

parse_path() {
	git rev-parse --show-prefix 2> /dev/null
}

export PS1="\n\$(parse_username) \[\033[32m\]\$(parse_reponame)\[\033[33m\](\$(parse_git_branch))\[\033[00m\] \$(parse_path)$ "

if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]];
then
	#echo ""
	exec tmux a;
else
	. ~/.bash_aliases
	. /home/jimmiebtlr/.nix-profile/etc/profile.d/nix.sh
fi
