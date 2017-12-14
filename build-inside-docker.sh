#!/usr/bin/env bash
# environmental and build settings
KEYFILE="${KEYFILE:-"$HOME/.ecdsakey"}"
#export GLUON_BRANCH="" # disable the autoupdater

GLUON_PRIORITY="${GLUON_PRIORITY:-7}"
export GLUON_RELEASE="v2017.1.4+bremen1+mablae1"
export GLUON_TARGET="ar71xx-generic"

# start of script
set -eu

echo "Starting of build for target ${GLUON_TARGET}...."
cd /app/gluon

mkdir -p /gluon-site-ffhb/gluon/output
rm -rf /gluon-site-ffhb/gluon/output/*

make update V=s&>/gluon-site-ffhb/gluon/output/update.log
make clean GLUON_TARGET="${GLUON_TARGET}" V=s&>/gluon-site-ffhb/gluon/output/clean.log
make --jobs=$(grep -c '^processor' /proc/cpuinfo) --output-sync=recurse GLUON_TARGET="${GLUON_TARGET}" V=s &>/gluon-site-ffhb/gluon/output/build.log

cp -Lr /app/gluon/output/* /gluon-site-ffhb/gluon/output/
echo "Build finished"