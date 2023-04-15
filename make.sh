#!/bin/bash

set -eu

usage()
{
    echo "Usage: ${0##*\/} <conv|update>" >&2
    exit 1
}

[ $# -eq 1 ] || usage

case "$1" in
    conv)
        podman run -it --rm --volume $(readlink -e $PWD):/build cv-builder
        ;;
    update)
        podman build --no-cache --rm --force-rm -t cv-builder .
        ;;
    *)
        usage
        ;;
esac
