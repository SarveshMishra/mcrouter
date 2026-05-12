#!/bin/bash -e
# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

## Build
# We copy the local repo rather than fetching from upstream, since we are building from a fork.
mkdir -p $MCROUTER_DIR/repo
cp -r /src $MCROUTER_DIR/repo/mcrouter

cd $MCROUTER_DIR/repo/mcrouter/mcrouter/scripts
sed -i 's/sudo //g' ./install_ubuntu_24.04.sh
sed -i 's/MAKE_ARGS="\$@"/MAKE_ARGS="-j$(nproc)"/g' ./common.sh
./install_ubuntu_24.04.sh $MCROUTER_DIR

# Strip the binary for smaller size
strip $MCROUTER_DIR/install/bin/mcrouter

# Clean up static libraries and includes since we only need the runtime
rm -rf $MCROUTER_DIR/install/lib/*.a
rm -rf $MCROUTER_DIR/install/include
