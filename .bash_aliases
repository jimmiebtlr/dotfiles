export EDITOR="vim";

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
       find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
            sed s/^..//) 2> /dev/null';

function vim() {
  nix-shell ~/.neovim.nix --command "nvim $@"
}
     
#alias vim="nix-shell ~/.neovim.nix --command nvim ";

alias "."="ls -a --color=auto";
alias ".."="cd ../";
alias gq="git add . && git commit -am \".\" && git push";
alias gp="git push";
alias gc="git add . && git commit --no-verify --status -a -v";
alias gs="git status";

alias grep="grep -I --color=auto --exclude-dir=node_modules --exclude-dir=.next --exclude-dir=vendor --exclude-dir=.git --exclude='*.map' --exclude-dir='swagger/**/*.json' --exclude-dir='jest' --exclude-dir='coverage'";

alias dc="docker-compose";
