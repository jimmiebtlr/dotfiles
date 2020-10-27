{ pkgs, ... }:

# Crostini workaround
# sudo umount /proc/{cpuinfo,diskstats,meminfo,stat,uptime}


{
  manual.manpages.enable = false;

  home.packages = [
    pkgs.bash-completion
    pkgs.cacert
    pkgs.curl
    pkgs.docker-compose
    pkgs.fzf
    pkgs.git

    pkgs.go
    pkgs.go-tools
    pkgs.delve
    pkgs.gocode-gomod
    pkgs.iferr
    pkgs.golint
    pkgs.gotags
    pkgs.go-motion
    pkgs.gomodifytags

    pkgs.google-cloud-sdk
    pkgs.htop
    pkgs.jq
    pkgs.kubectl
    pkgs.nano
    pkgs.lua53Packages.luarocks-nix
    pkgs.neovim
    pkgs.nettools
    pkgs.nix-bash-completions
    pkgs.nodejs
    pkgs.yarn
    pkgs.nox
    pkgs.powerline-fonts
    pkgs.terraform_0_13
    pkgs.tflint
    pkgs.tmux
    pkgs.unzip
    pkgs.which
    pkgs.whois
    pkgs.zip

    # build tools/libs
    pkgs.stdenv
    pkgs.gcc
    pkgs.glib
    pkgs.binutils

    pkgs.jetbrains.pycharm-community
  ];


  programs.bash = {
    enable=true;

    historyFileSize = 50000;

    sessionVariables={
      # Required for home manager
      NIX_PATH="$HOME/.nix-defexpr/channels\${NIX_PATH:\+:}$NIX_PATH";

      EDITOR="nvim";

      FZF_DEFAULT_COMMAND=''(git ls-tree -r --name-only HEAD ||
       find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
            sed s/^..//) 2> /dev/null'';

      # Seems required for some things to work (like man pages).
      LC_ALL="C.UTF-8";
      LANG="en_US.UTF-8";
      LANGUAGE="en_US:en";
    };

    shellAliases={
      vim="nvim";
      vnix="vim ~/.config/nixpkgs/home.nix && home-manager switch && source ~/.bashrc && cd ~ && gq && cd -";

      "."="ls -a --color=auto";
      ".."="cd ../";

      gq="git add . && git commit -am \".\" && git push";
      gp="git push";
      gc="git add . && git commit --no-verify --status -a -v";
      gs="git status";

      grep="grep -I --color=auto --exclude-dir=node_modules --exclude-dir=.next --exclude-dir=vendor --exclude-dir=.git --exclude='*.map' --exclude-dir='swagger/**/*.json' --exclude-dir='jest' --exclude-dir='coverage' --exclude-dir='.julia'";

      ds="sudo systemctl start docker";
      dc="docker-compose";

      swagger="docker run --rm -it -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger";
    };

    initExtra=''
      PATH="$PATH:~/go/bin"
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

      source ~/.nix-profile/etc/profile.d/nix.sh;

      #if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]];
      #then
      #  exec tmux a;
      #fi

      completionsDir=~/.nix-profile/share/bash-completion/completions/
      source $completionsDir/docker-compose
      source $completionsDir/pkill
      source $completionsDir/pgrep
      #source $completionsDir/bazel
      source $completionsDir/npm
      source $completionsDir/ssh
    '';
  };

  programs.git = {
    enable = true;
    userName = "Jimmie Butler";
    userEmail = "jimmiebtlr@gmail.com";

    aliases={
      lg="log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    extraConfig={
      push={
        default="current";
      };
    };
  };

  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/%r@%h-%p";
    controlPersist = "600";
    serverAliveInterval = 60;


    extraConfig = ''
# If having trouble with password auth for ssh-copy-id use
# -o PreferredAuthentications=password


Host *
  PreferredAuthentications=publickey

Host akeneo-dev
  HostName 35.194.78.67

Host mathison-dev
        HostName 34.74.148.251
        User jimmiebtlr

Host stylegan
      HostName 34.105.79.81

Host stylegan2
  User paperspace
  HostName 184.105.6.126
    '';
  };

  programs.tmux = {
    enable = true;

    newSession = true;
    sensibleOnTop = true;

    # nvim recommends
    # escapeTime = 10
    #set-option -g default-terminal "screen-256color"

    extraConfig = ''
# Open new panes and windows in current directory
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"

unbind ^Z
    '';

    historyLimit=20000;

    plugins= with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    tmuxinator = {
      enable = true;
    };
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
