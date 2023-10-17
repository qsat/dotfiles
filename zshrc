if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
  
#alias vim=/usr/local/bin/nvim
alias vim=/opt/homebrew/bin/nvim
alias awsd='sudo docker run --rm -it -v ~/.aws:/root/.aws -v $PWD:/tmp amazon/aws-cli'

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

alias vime='vim $(fzf)'
alias gl="git log --graph --pretty='format:%C(yellow)%h%Creset %C(White)%cd%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset' --date=iso"
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

#エディタ
export EDITOR=vim
export FZF_DEFAULT_OPTS='
  --bind ctrl-j:down,ctrl-k:up
  --color fg:242,bg:234,hl:65,fg+:15,bg+:234,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

export ANDROID_HOME=/usr/local/share/android-sdk
export PATH=/usr/local/git/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$PATH
#その他
#キーバインド
bindkey -v

export TERM=xterm-256color
export XDG_CONFIG_HOME=~/dotfiles

#補間
# autoload -Uz compinit && compinit -C -d ~/.zcompdump

# ------------------------------------------------------------------------
# anyenv
# ------------------------------------------------------------------------
eval "$(anyenv init -)"

#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload -Uz add-zsh-hook
autoload -Uz colors; colors

#履歴
#履歴を保存するファイル指定
HISTFILE="$HOME/.zsh_history"

#履歴の件数
HISTSIZE=1000
SAVEHIST=1000

#重複した履歴を保存しない
setopt hist_ignore_dups

#履歴を共有する
setopt share_history

#先頭にスペースを入れると履歴に残さない
setopt hist_ignore_space

#cdの設定
#ディレクトリ名だけで移動する。
setopt auto_cd

#自動でpushdする
setopt auto_pushd

#pushdの履歴は残さない。
setopt pushd_ignore_dups

alias ll='ls -al'
alias lla='ls -al'
alias less='less -qR'
alias lesss='less -qRsS'

#ビープ音ならなさない
setopt nobeep

# direnv
eval "$(direnv hook zsh)"

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# export DOCKER_HOST="localhost"

#履歴の検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
#履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

fzf-git-diff() {
    # local branches=$(git branch -a) 
    # local trunk=$(echo "$branches"|fzf|tr -d ' ')
    # local trunk=$(git symbolic-ref --short refs/remotes/origin/HEAD)
    local trunk=$1
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local res=$(git diff --name-only $(git show-branch --sha1-name $trunk $branch | tail -1 | awk -F'[]~^[]' '{print $2}')|fzf)
    
    if [ -n "$res" ]; then
        # BUFFER+="git diff $trunk -- $res"
        nvim -d <(git show $trunk:$res) $res
    else
        return 1
    fi
}

alias ef=fzf-git-diff

fzf-git-diff-files() {
    local trunk=$1
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local res=$(git diff --name-only $(git show-branch --sha1-name $trunk $branch | tail -1 | awk -F'[]~^[]' '{print $2}'))
    
    if [ -n "$res" ]; then
      echo $res;
    else
        return 1
    fi
}

alias eff=fzf-git-diff-files

fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
    zle accept-line
}

zle -N fzf-z-search
bindkey '^e' fzf-z-search

# worktree移動
function cdworktree() {
    # カレントディレクトリがGitリポジトリ上かどうか
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo fatal: Not a git repository.
        return
    fi

    local selectedWorkTreeDir=`git worktree list | fzf | awk '{print $1}'`

    if [ "$selectedWorkTreeDir" = "" ]; then
        # Ctrl-C.
        return
    fi

    BUFFER+="cd $selectedWorkTreeDir"
    zle accept-line
}

zle -N cdworktree
bindkey '^w' cdworktree

fbr() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

zle -N fbr
bindkey '^b' fbr

function ghq-list() {
  find $(ghq root) -type d -maxdepth 1 | grep -v DS_Store | sed -e "s#$(ghq root)/##g"
}

function new-session-with-repo() {
  local project dir repository session current_session
  project=$(ghq-list | fzf --prompt='Project >')

  echo $project

  if [[ $project == "" ]]; then
    return 1
  elif [[ -d ~/Projects/${project} ]]; then
    dir=~/Projects/${project}
  elif [[ -d ~/.go/src/${project} ]]; then
    dir=~/.go/src/${project}
  fi

  if [[ ! -z ${TMUX} ]]; then
    repository=${dir##*/}
    session=${repository//./-}
    current_session=$(tmux list-sessions | grep 'attached' | cut -d":" -f1)

    if [[ $current_session =~ ^[0-9]+$ ]]; then
      cd $dir
      tmux rename-session $session
    else
      tmux list-sessions | cut -d":" -f1 | grep -e "^$session\$" > /dev/null
      if [[ $? != 0 ]]; then
        tmux new-session -d -c $dir -s $session
      fi
      tmux switch-client -t $session
    fi
  else
    cd $dir
  fi
}

zle -N new-session-with-repo
bindkey '^A' new-session-with-repo

fzf-vifm() {
   local res=$(z | sort -rn | cut -c 12- | fzf)
   local dst="$(command vifm --choose-dir - $res)"
   if [ -z "$dst" ]; then
      echo 'Directory picking cancelled/failed'
      return 1
   fi
   cd "$dst"
}
call-fzf-vifm() {
if [[ -z $BUFFER ]]; then
  # interpreted at start, not when leaving
  BUFFER="fzf-vifm"
  zle accept-line
fi
}
zle -N call-fzf-vifm
bindkey '^g' call-fzf-vifm

# ctrl v file manager
vicd()
{
   # from https://wiki.vifm.info/index.php?title=How_to_set_shell_working_directory_after_leaving_Vifm
   # Syncro vifm and shell
   local dst="$(command vifm --choose-dir - .)"
   if [ -z "$dst" ]; then
      echo 'Directory picking cancelled/failed'
      return 1
   fi
   cd "$dst"
}
vifm-call() {
if [[ -z $BUFFER ]]; then
  # interpreted at start, not when leaving
  BUFFER="vicd"
  zle accept-line
fi
}
zle -N vifm-call
bindkey '^v' vifm-call

function memo () {
    vim --cmd 'cd ~/memos' ~/memos/`memof $1`
}

function memos () {
    vim --cmd 'cd ~/memos' ~/memos/
}

function memof () {
    echo `date +%F``echo $1 | sed 's/^\(.\)/-\1/'`.md
}

function sshdockercontainer() {
  docker ps --quiet
  docker exec -it `docker ps --format "{{.Names}}" | fzf` sh
}

alias sdc=sshdockercontainer


# @args: $branch -- target branch name when show diff
# @depended: [git, peco, vimdiff]
git-select() {
  branch=$1
  file="$(git diff $branch --name-only | sort | fzf)"
  git difftool -t vimdiff $branch -- $file
}

zle -N git-select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  export ZPLUG_HOME=/opt/homebrew/opt/zplug
  source $ZPLUG_HOME/init.zsh
# zplug
# source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# 非同期処理できるようになる
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-autosuggestions"
# 補完強化
zplug "zsh-users/zsh-completions"
# ディレクトリ履歴
zplug "rupa/z", use:"*.sh"

zplug "arks22/tmuximum", as:command

# Then, source plugins and add commands to $PATH
zplug load

alias t=tmuximum

# limelight_path=/usr/local/bin/limelight
# if [ ! -e "$limelight_path" ]; then
#     git clone https://github.com/koekeishiya/limelight
#     cd limelight
#     make
#     sudo mv ./bin/limelight /usr/local/bin/limelight
#     cd ../
#     rm -rf limelight
# fi
# 
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/01017830/.sdkman"
[[ -s "/Users/01017830/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/01017830/.sdkman/bin/sdkman-init.sh"
