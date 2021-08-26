if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
  
alias vim=/usr/local/bin/nvim
alias awsd='sudo docker run --rm -it -v ~/.aws:/root/.aws -v $PWD:/tmp amazon/aws-cli'

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
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$PATH
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


# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme, lazy:true
# zplug "junegunn/fzf-bin", \
#     from:gh-r, \
#     as:command, \
#     rename-to:fzf, \
#     use:"*darwin*amd64*", \
#     lazy:true
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-autosuggestions"
# zplug "rupa/z", use:z.sh
# zplug "b4b4r07/gist", from:gh-r, as:command, use:"*darwin*amd64*", lazy:true

# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi
# Then, source plugins and add commands to $PATH
# zplug load

# if [[ -z "$TMUX" ]]
# then
#   tmux new-session;
#   exit;
# fi

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
    vim --cmd 'cd ~/Memo' ~/Memo/`memof $1`
}

function memos () {
    vim --cmd 'cd ~/Memo' ~/Memo/
}

function memof () {
    echo `date +%F``echo $1 | sed 's/^\(.\)/-\1/'`.md
}

function sshdockercontainer() {
  sudo docker ps --quiet
  sudo docker exec -it `sudo docker ps --format "{{.Names}}" | fzf` bash
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


# zplugin
# $ sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin ice wait'0'
zplugin light zsh-users/zsh-autosuggestions

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice from"gh-r" as"program" mv"fzf-* -> fzf"
zplugin light junegunn/fzf-bin

zplugin ice wait'0' from"gh-r" as"program"
zplugin light b4b4r07/gist

zplugin ice wait'0' as"program" src"z.sh"
zplugin light rupa/z 

zplugin ice wait'0' as"command" atload'if [ -z "$TMUX" ]; then tmuximum; fi'
zplugin light arks22/tmuximum

zplugin creinstall -q %HOME/my_completions
zplugin ice wait"!0" atinit"zpcompinit -q; zpcdreplay -q"
zplugin light zdharma/fast-syntax-highlighting

alias t=tmuximum

limelight_path=/usr/local/bin/limelight
if [ ! -e "$limelight_path" ]; then
    git clone https://github.com/koekeishiya/limelight
    cd limelight
    make
    mv ./bin/limelight /usr/local/bin/limelight
    cd ../
    rm -rf limelight
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/01017830/.sdkman"
[[ -s "/Users/01017830/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/01017830/.sdkman/bin/sdkman-init.sh"
