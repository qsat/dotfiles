alias nvim=~/Apps/nvim-osx64/bin/nvim
#alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
alias vim=nvim
alias vi=nvim
alias gl="git log --graph --pretty='format:%C(yellow)%h%Creset %C(White)%cd%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset' --date=iso"
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

export TERM=xterm-256color
#export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
export ANDROID_HOME=/usr/local/opt/android-sdk

export XDG_CONFIG_HOME=~/dotfiles

#補間
autoload -U compinit; compinit

# ------------------------------------------------------------------------
# anyenv
# ------------------------------------------------------------------------
if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in `find $HOME/.anyenv/envs -type d -d 1`
    do
        export PATH="$D/shims:$PATH"
    done

  fi

#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload -Uz add-zsh-hook
autoload -Uz colors; colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%b) %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%b|%a) %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

RPROMPT="%1(v|%F{green}%1v%f|)"
PROMPT="
%{${fg[blue]}%}%~%{${reset_color}%}
%n$ "


PROMPT2='[%n]> ' 

#履歴
#履歴を保存するファイル指定
HISTFILE="$HOME/.zsh_history"

#履歴の件数
HISTSIZE=100000
SAVEHIST=100000

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

#ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac 

#色の設定
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias less='less -qR'
alias lesss='less -qRsS'

#その他
#キーバインド
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

#ビープ音ならなさない
setopt nobeep

#エディタ
export EDITOR=/usr/bin/vim
# direnv
eval "$(direnv hook zsh)"

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

#個別設定を読み込む
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:/Applications/android-sdk-macosx/tools"
export PATH="$PATH:/Applications/android-ndk-r10e"
export ANDROID_NDK="/Applications/android-ndk-r10e"
export DOCKER_HOST="localhost"

#履歴の検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
#履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/01017830/.sdkman"
[[ -s "/Users/01017830/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/01017830/.sdkman/bin/sdkman-init.sh"


function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]}tmux enabled.${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
