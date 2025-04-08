#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SDK_PATH=${SCRIPT_PATH}/../../sdk

if [ ! -d ${SDK_PATH} ]; then
    source ${SCRIPT_PATH}/lone_sdk.sh
fi

echo "Setup Matter environment"
cd ${SDK_PATH}
source ./Scripts/activate.sh
