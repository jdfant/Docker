#! /bin/bash

PYTHON_VERSION="python3.12"
GIT_SOURCE=/Lambda_Layer/GIT/lambda-layer-builder
GIT_BRANCH="dev"
BUILD_DIR=/Lambda_Layer/VIRTUALENV
PREFIX="${BUILD_DIR}"/python
TARGET="${PREFIX}"/lib/"${PYTHON_VERSION}"/site-packages/
ZIP_FILE=lambda_layer_"$(date '+%Y-%m-%d')".zip
ZIP_FILE_PATH=/Lambda_Layer/ZIP_FILES

setup_git(){
    if [ -z "$(ls "${GIT_SOURCE}")" ]; then 
        echo -e "\\nThe Lambda Layer Git repo does not exist\\nPulling git resources\\n"
        mkdir -p /Lambda_Layer/GIT
        cd /Lambda_Layer/GIT || exit    
        git clone http://github.com/jdfant/docker.git || exit
        git checkout "${GIT_BRANCH}" || exit
    else
        echo -e "\\nUpdating git resources\\n"
        cd "${GIT_SOURCE}" || exit
        git checkout "${GIT_BRANCH}" || exit
        git pull || exit
    fi
}

virtualenv_build(){
    mkdir -p "${BUILD_DIR}"
    cp /Lambda_Layer/requirements.txt "${BUILD_DIR}" || exit
    cd "${BUILD_DIR}" || exit
    python3 -m venv "$(pwd)"
    source bin/activate
    pip3 install --no-cache-dir -U "$(grep pip requirements.txt)" 2>/dev/null
    pip3 install --no-cache-dir -U "$(grep setup requirements.txt)" 2>/dev/null
    pip3 install --no-cache-dir -U wheel 2>/dev/null
    pip3 install --no-cache-dir -r requirements.txt --prefix "${PREFIX}"

    deactivate
}

copy_common(){
    cd "${GIT_SOURCE}" || exit
    git pull
    git checkout "${GIT_BRANCH}"
    echo -e "\\nWorking Branch Name is:\\n$(git branch)\\n\\n"
    cd "${BUILD_DIR}" || exit
    cp -Rv "${GIT_SOURCE}"/common "${TARGET}" || exit
}

create_zip(){
    cd "${TARGET}" || exit
    rm -f "${BUILD_DIR}"/requirements.txt
    mkdir -p "${ZIP_FILE_PATH}"
    zip -r "${ZIP_FILE_PATH}"/"${ZIP_FILE}" ./* 
    echo
    zip -T "${ZIP_FILE_PATH}"/"${ZIP_FILE}"
    echo -e "\\nLambda Layer Zip file is ready in ${ZIP_FILE_PATH}/${ZIP_FILE}\\n"
}
setup_git
virtualenv_build
copy_common
create_zip