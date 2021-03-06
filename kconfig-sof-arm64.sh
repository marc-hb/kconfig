#!/bin/bash
KCONFIG_DIR=$(dirname ${BASH_SOURCE[0]})
echo $KCONFIG_DIR

BUILD_DIR=$(pwd)

# find merge_config in code directory
FILE=scripts/kconfig/merge_config.sh
if test -f "$FILE"; then
    COMMAND=$FILE;
else
    # try if the script in a work directory without the -build path
    CODE_DIR=${BUILD_DIR%-build}
    if test -f "$CODE_DIR/$FILE"; then
	COMMAND=$CODE_DIR/$FILE;
    else
	echo "error: could not find $FILE";
	exit 1;
    fi
fi

make defconfig ARCH=arm64
$COMMAND -m .config \
	 $KCONFIG_DIR/nobloat-imx-defconfig \
	 $KCONFIG_DIR/sof-defconfig  \
	 $KCONFIG_DIR/sof-dev-defconfig \
	 $@
make olddefconfig ARCH=arm64
