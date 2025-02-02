#!/bin/sh

cd "$HOME/propagation/3.21"

. ./config.sh

REPOS_SUBDIR="books"
REPOS_ROOT="$HOME/PACKAGES/$BIOC_VERSION/$REPOS_SUBDIR"
DEST="webadmin@master.bioconductor.org:/extra/www/bioc/packages/$BIOC_VERSION/$REPOS_SUBDIR"

rsync --delete -ave ssh $REPOS_ROOT/src $REPOS_ROOT/bin $DEST

