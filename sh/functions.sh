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
        export TERMCOLOR="light"
        echo "light" > "${DOTFILES_COLORSCHEME_FILE}"
        # FIXME should check if tmux is running
        tmux set-environment -g TERMCOLOR light
        cp -f ${DOTFILES}/alacritty/alacritty-light.yml ${HOME}/.config/alacritty/alacritty.yml
        cp -f ${DOTFILES}/powerline/config-light.json ${HOME}/.config/powerline/config.json
        powerline-daemon --replace &> /dev/null &
}

function set-color-dark() {
        export TERMCOLOR="dark"
        echo "dark" > "${DOTFILES_COLORSCHEME_FILE}"
        # FIXME should check if tmux is running
        tmux set-environment -g TERMCOLOR dark
        cp -f ${DOTFILES}/alacritty/alacritty-dark.yml ${HOME}/.config/alacritty/alacritty.yml
        cp -f ${DOTFILES}/powerline/config-dark.json ${HOME}/.config/powerline/config.json
        powerline-daemon --replace &> /dev/null &
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

function overleaf-sync() {
        git fetch && git stash && git rebase && git stash pop
}

function make-ctags() {
        rg --files | ctags -R --links=no -L - -f tags
}

function rsync-git() {
        rsync -avhz --delete --exclude .git --filter=":- .gitignore" ./ $1
}
