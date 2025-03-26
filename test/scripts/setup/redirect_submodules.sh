#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

DEBUG_SHELL=${DEBUG_SHELL:-"0"}
[ "${DEBUG_SHELL}" = "1" ] && set -x

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SDK_PATH=${SCRIPT_PATH}/../../sdk
SDK_TOKEN="$(cat ${SCRIPT_PATH}/token)"

cd ${SDK_PATH}
for LINE in $(git config -f .gitmodules --list | grep "\.url=git@[^.]")
do
    SUBPATH=$(echo "${LINE}" | sed "s|^submodule\.\([^.]*\)\.url.*$|\1|")
    LOCATION=$(echo "${LINE}" | sed 's/.*git@gitlab.com://g')
    SUBURL="https://oauth2:$SDK_TOKEN@gitlab.com/$LOCATION"
    
    git config submodule."${SUBPATH}".url "${SUBURL}"
done

git config --get-regexp '^submodule\..*\.url$'
cd ${SDK_PATH}/..
