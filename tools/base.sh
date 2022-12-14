#!/usr/bin/env zsh

set -evx

export TOOLS_DIR="$(dirname "$0")"
export BUILD_DIR=${ROOT}/build
export COMPRESS_DIR=${ROOT}/source
export COMPRESS_FILE=${COMPRESS_DIR}/${PROJECT}-${VERSION}.tar.gz
export SOURCE_DIR=${BUILD_DIR}/source/${PROJECT}
export CMAKE_BUILD_DIR=${SOURCE_DIR}/build
export DIST_DIR=${BUILD_DIR}/dist/${PROJECT}
export OS=$(uname)
export ARCH=$(arch)
export https_proxy=http://127.0.0.1:6152
export http_proxy=http://127.0.0.1:6152
export all_proxy=socks5://127.0.0.1:6153

export ZLIB_DIR=${BUILD_DIR}/dist/zlib
export OPENSSL_DIR=${BUILD_DIR}/dist/openssl

export OPENSSL_ROOT_DIR="${OPENSSL_DIR}"

# export PKG_CONFIG_PATH="${DIST_DIR}":$PKG_CONFIG_PATH

if [ "$OS" = "Darwin" ]; then
    echo this is $OS
    # export OPENSSL_ROOT_DIR=$(brew --prefix openssl@3)
else
    echo this is $OS
    # export OPENSSL_ROOT_DIR=/usr/local
fi

echo "build ${PROJECT}-${VERSION} in ${ROOT} for ${OS}-${ARCH}"

function decompress() {
    if [ ! -d "${SOURCE_DIR}" ]; then
        echo "decompress ${COMPRESS_FILE} to ${SOURCE_DIR}"
        mkdir -p ${SOURCE_DIR}
        tar -xzf ${COMPRESS_FILE} -C ${SOURCE_DIR} --strip-components=1
    fi
}

function create_cmake_build_dir() {
    echo "create cmake build dir ${COMPRESS_FILE} to ${SOURCE_DIR}"
    rm -rf "${CMAKE_BUILD_DIR}"
    mkdir -p "${CMAKE_BUILD_DIR}"
}
