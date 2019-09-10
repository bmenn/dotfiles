#!/bin/sh

function is_osx() {
        if [ "$(uname -o)" == "Darwin" ]; then
                return 0
        else
                return 1
        fi
}

function is_linux() {
        if [ "$(uname -o)" == "Linux" ]; then
                return 0
        else
                return 1
        fi
}
