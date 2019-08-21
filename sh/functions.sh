# Add Anaconda path if present
[ -d "${HOME}/anaconda/bin/" ] && PATH="${PATH}:${HOME}/anaconda/bin/"
[ -d "/opt/miniconda3/bin/" ] && PATH="${PATH}:/opt/miniconda3/bin/"
# If Homebrew coreutils are installed, prefer though
[ -d "/usr/local/opt/coreutils/libexec/gnubin" ] && PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"

export TERMCOLOR="dark"

# Load z
source "${DOTFILES}/vendor/z/z.sh"
# Load marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# Cross shell aliases
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -lh --color=auto'
alias g='git'
alias mk='minikube'
alias kc='kubectl'
alias ap='ansible-playbook'

# Usage: activate
# Description: activates python virtualenv
function activate {
        source venv/bin/activate
}

# Usage: extract <file>
# Description: extracts archived files (maybe)
function extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -xvf $1        ;;
            *.tar.gz)   tar -xvf $1        ;;
            *.bz2)      bzip2 -d $1         ;;
            *.gz)       gunzip -d $1        ;;
            *.tar)      tar -xvf $1         ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *.rar)      unrar x $1            ;;
            *)          echo "'$1' Error. Please go away" ;;
        esac
        else
            echo "'$1' is not a valid file"
    fi
}

# Usage: show-archive <archive>
# Description: view archive without unpack
function show-archive() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)     tar -jtf $1 ;;
            *.tar.gz)      tar -ztf $1 ;;
            *.tar)         tar -tf $1  ;;
            *.tgz)         tar -ztf $1 ;;
            *.zip)         unzip -l $1 ;;
            *.rar)         rar vb $1   ;;
            *)             echo "'$1' Error. Please go away" ;;
        esac
        else
            echo "'$1' is not a valid archive"
    fi
}

function set-color-light() {
        echo -e "\033]50;SetProfile=tmux - Solarized Light\a"
        export TERMCOLOR="light"
}

function set-color-dark() {
        printf "\x1b]50;SetProfile=tmux - Solarized Dark\x07"
        export TERMCOLOR="dark"
}

function pet-prev(){
        PREV=$(fc -lrn | head -n 1)
        sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
