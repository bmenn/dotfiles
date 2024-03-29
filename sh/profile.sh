# Add Anaconda path if present
[ -d "${HOME}/anaconda/bin/" ] && PATH="${PATH}:${HOME}/anaconda/bin/"
[ -d "/opt/miniconda3/bin/" ] && PATH="${PATH}:/opt/miniconda3/bin/"
# Homebrew path
_uname="$(uname)"
case "${_uname}" in
        Darwin)
        if [[ "$(uname -m)" == "arm64" ]]; then
                [ -d "/opt/homebrew/bin" ] \
                        && PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
        else
                [ -d "/usr/local/opt/coreutils/libexec/gnubin" ] \
                        && PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
        fi
        ;;
esac

export DOTFILES_COLORSCHEME_FILE="${HOME}/.cache/dotfiles-colorscheme"
if [ -z "${TERMCOLOR}" ]; then
        [ -f "${DOTFILES_COLORSCHEME_FILE}" ] && \
                export TERMCOLOR="$(cat ${DOTFILES_COLORSCHEME_FILE})" \
                || export TERMCOLOR="dark"
fi

# Set default Python user location
export PTYHON_VERSION="$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')"
export PYTHON3_USER_LIB="$(python3 -c 'import site; print(site.USER_SITE)')"
export PYTHON3_SITE_LIB="$(python3 -c 'import site; print(site.PREFIXES[1])')/lib/python${PYTHON_VERSION}/site-packages"
export PATH="${PYTHON3_USER_LIB}/../../../bin:${PATH}"

# Load z
source "${DOTFILES}/vendor/z/z.sh"
# Load marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# Settings for less
export LESS="--raw-control-chars --no-init --quit-if-one-screen"

export FZF_DEFAULT_COMMAND="rg --files"

export PIPENV_VENV_IN_PROJECT=1

source ${DOTFILES}/sh/aliases.sh
source ${DOTFILES}/sh/functions.sh
source ${HOME}/.profile_local
