#!/usr/bin/env bash
set -e
export ROOT=$(pwd)
export TOOLS_DIR="$(dirname "$0")"

LIBGIT2_DIST_DIR="$ROOT/build/dist/libgit2"
LIBSSH2_DIST_DIR="$ROOT/build/dist/libssh2"

if [ "$(uname)" = "Darwin" ]; then
    export OPENSSL_LIB_DIR=$(brew --prefix openssl@3)/lib
    export PKG_CONFIG_PATH="${LIBGIT2_DIST_DIR}/lib/pkgconfig:${LIBSSH2_DIST_DIR}/lib/pkgconfig":$PKG_CONFIG_PATH
fi

headers="git2.h"
staticLibraries="libgit2.a libssh2.a libssl.a libcrypto.a libiconv.a libz.a"
libraryPaths="${LIBGIT2_DIST_DIR}/lib ${LIBSSH2_DIST_DIR}/lib ${OPENSSL_LIB_DIR}"
compilerOpts="-I${LIBGIT2_DIST_DIR}/include"
linkerOpts="$(pkg-config --libs libgit2 --static)"

DEF_FILE="$ROOT/libgit2.def"
echo "headers = $headers" > "$DEF_FILE"
echo "staticLibraries = $staticLibraries" >> "$DEF_FILE"
echo "libraryPaths = $libraryPaths" >> "$DEF_FILE"
echo "compilerOpts = $compilerOpts" >> "$DEF_FILE"
#echo "linkerOpts = $linkerOpts" >> "$DEF_FILE"
