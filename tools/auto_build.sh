#!/usr/bin/env bash
set -evx
export ROOT=$(pwd)
export TOOLS_DIR="$(dirname "$0")"
${TOOLS_DIR}/build_zlib.sh
${TOOLS_DIR}/build_openssl.sh
${TOOLS_DIR}/build_libssh2.sh
${TOOLS_DIR}/build_libgit2.sh