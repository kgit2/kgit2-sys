#!/usr/bin/env bash
set -e
export ROOT=$(pwd)
export TOOLS_DIR="$(dirname "$0")"

export BUILD_DIR="${ROOT}/build"

export LIBGIT2_DIST_DIR="${BUILD_DIR}/dist/libgit2"
export LIBSSH2_DIST_DIR="${BUILD_DIR}/dist/libssh2"
export OPENSSL_DIST_DIR="${BUILD_DIR}/dist/openssl"
export ZLIB_DIST_DIR="${BUILD_DIR}/dist/zlib"

if [ "$(uname)" = "Darwin" ]; then
    export OPENSSL_LIB_DIR=$(brew --prefix openssl@3)/lib
    export PKG_CONFIG_PATH="${LIBGIT2_DIST_DIR}/lib/pkgconfig:${LIBSSH2_DIST_DIR}/lib/pkgconfig:${OPENSSL_DIST_DIR}/lib/pkgconfig":$PKG_CONFIG_PATH
fi

headers="git2.h git2/reflog.h git2/sys/reflog.h git2/sys/odb_backend.h git2/sys/mempack.h git2/sys/repository.h"
staticLibraries="libgit2.a libssh2.a libssl.a libcrypto.a libz.a"
libraryPaths="${LIBGIT2_DIST_DIR}/lib ${LIBSSH2_DIST_DIR}/lib ${OPENSSL_DIST_DIR}/lib ${ZLIB_DIST_DIR}/lib"
compilerOpts="-I${LIBGIT2_DIST_DIR}/include"
linkerOpts="$(pkg-config --libs libgit2 --static)"

DEF_FILE="$ROOT/libgit2.def"
echo "headers = $headers" > "$DEF_FILE"
echo "staticLibraries = $staticLibraries" >> "$DEF_FILE"
echo "libraryPaths = $libraryPaths" >> "$DEF_FILE"
echo "compilerOpts = $compilerOpts" >> "$DEF_FILE"
echo "linkerOpts = $linkerOpts" >> "$DEF_FILE"
echo "" >> "$DEF_FILE"
echo "noStringConversion = git_attr_value git_mailmap_from_buffer" >> "$DEF_FILE"
echo "" >> "$DEF_FILE"
echo "---" >> "$DEF_FILE"
echo "" >> "$DEF_FILE"
echo "const char *git_attr__true  = \"[internal]__TRUE__\";" >> "$DEF_FILE"
echo "const char *git_attr__false = \"[internal]__FALSE__\";" >> "$DEF_FILE"
echo "const char *git_attr__unset = \"[internal]__UNSET__\";" >> "$DEF_FILE"