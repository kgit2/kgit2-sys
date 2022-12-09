#!/usr/bin/env bash
set -evx
export ROOT=$(pwd)
export TOOLS_DIR="$(dirname "$0")"
export PROJECT=libssh2
export VERSION=1.10.0
source $TOOLS_DIR/base.sh

decompress

create_cmake_build_dir

cd ${CMAKE_BUILD_DIR}
cmake .. \
    -DBUILD_SHARED_LIBS=OFF \
    -DCRYPTO_BACKEND=OpenSSL \
    -DENABLE_ZLIB_COMPRESSION=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${DIST_DIR}" \
    -DCMAKE_PREFIX_PATH="${OPENSSL_ROOT_DIR};${ZLIB_DIR}"

cmake --build . --target install -j6

echo "Build ${PROJECT} Successful"
