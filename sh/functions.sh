# Add Anaconda path if present
[ -d "${HOME}/anaconda/bin/" ] && PATH="${HOME}/anaconda/bin/:${PATH}"

# Load z
source "${DOTFILES}/vendor/z/z.sh"
# Load marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

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
        printf "\033]1337;SetProfile=tmux - Solarized Light\007"
}

function set-color-dark() {
        printf "\033]1337;SetProfile=tmux - Solarized Dark\007"
}
