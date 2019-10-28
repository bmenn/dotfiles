# Add Anaconda path if present
[ -d "${HOME}/anaconda/bin/" ] && PATH="${PATH}:${HOME}/anaconda/bin/"
[ -d "/opt/miniconda3/bin/" ] && PATH="${PATH}:/opt/miniconda3/bin/"
# If Homebrew coreutils are installed, prefer though
[ -d "/usr/local/opt/coreutils/libexec/gnubin" ] && PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
[ -z "${TERMCOLOR}" ] && export TERMCOLOR="dark"

# Load z
source "${DOTFILES}/vendor/z/z.sh"
# Load marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

source ${DOTFILES}/sh/aliases.sh
source ${DOTFILES}/sh/functions.sh
source ${HOME}/.profile_local
