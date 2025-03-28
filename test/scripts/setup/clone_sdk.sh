#!/bin/bash

SMALLEST_SDK=0

usage()
{
    echo -e "Usage: $0 [-s|-h]\n"
}

help()
{
  usage
    echo -e "DESCRIPTION:"
    echo -e "This script runs pull code.."
    echo -e
    echo -e "OPTIONS:"
    echo -e "  -s   Fetch submodules without history"
    echo -e "  -h   Prints this help\n"
}

unset OPTIND
while getopts s,h opts
do
    case "${opts}" in
        s)  SMALLEST_SDK=1;;
        h)  help; exit;;
        \?) help; exit;;
    esac
done

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SDK_PATH=${SCRIPT_PATH}/../../sdk
SDK_VERSION="0.8.3"
SDK_SSH_URL=git@gitlab.com:qorvo/wcon/lps_sw/iot_sdk_ikea.git
SDK_TOKEN_FILE=${SCRIPT_PATH}/token
if [ -f ${SDK_TOKEN_FILE} ]; then
    SDK_TOKEN="$(cat ${SCRIPT_PATH}/token)"
    SDK_HTTP_URL=https://oauth2:${SDK_TOKEN}@gitlab.com/qorvo/wcon/lps_sw/iot_sdk_ikea.git
fi

echo "Start to clone iot_sdk_ikea ${SDK_VERSION}"
git clone -b ${SDK_VERSION} ${SDK_HTTP_URL} ${SDK_PATH}

'
if [ ! -d ${SDK_PATH} ]; then
    echo "Clone iot_sdk_ikea ${SDK_VERSION}"
    if [ "${SMALLEST_SDK}" == 0 ]; then
        if [ ! -n "$SDK_TOKEN" ]; then
            echo ${SDK_SSH_URL}
            git clone --branch ${SDK_VERSION} ${SDK_SSH_URL} ${SDK_PATH}
        else
            echo ${SDK_HTTP_URL}
            git clone --branch ${SDK_VERSION} ${SDK_HTTP_URL} ${SDK_PATH}
        fi
    else
        if [ ! -n "$SDK_TOKEN" ]; then
            echo ${SDK_SSH_URL}
            git clone --depth 1 --branch ${SDK_VERSION} ${SDK_SSH_URL} ${SDK_PATH}
        else
            echo ${SDK_HTTP_URL}
            git clone --depth 1 --branch ${SDK_VERSION} ${SDK_HTTP_URL} ${SDK_PATH}
        fi
    fi
else
    echo "iot_sdk_ikea ${SDK_VERSION} already installed"
fi

if [ -d ${SDK_PATH} ]; then
    if [ -n "$SDK_TOKEN" ]; then
        echo "Redirect submodules"
        source ${SCRIPT_PATH}/redirect_submodules.sh
    fi
fi
'
