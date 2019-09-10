#!/bin/sh
BASENAME="${0}"
BASEPATH="$(dirname "${BASENAME}")/.."
source  ${BASEPATH}/sh/oscheck.sh

LATEST_URL="https://github.com/go-jira/jira/releases/latest"
OSX_BINARY="jira-darwin-10.6-amd64"
LINUX_BINARY="jira-linux-amd64"

function get_url() {
        relpath="$(curl -Ls "${LATEST_URL}" | grep "href=.*${1}" | cut -d '"' -f 2)"
        echo "https://github.com${relpath}"
}

if is_osx; then
        artifact_url="$(get_url "${OSX_BINARY}")"
fi

mkdir -p ${HOME}/.local/bin
curl -o ${HOME}/.local/bin/jira -L "${artifact_url}"
chmod +x ${HOME}/.local/bin/jira
