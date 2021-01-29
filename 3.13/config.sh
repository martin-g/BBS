#!/bin/bash
# =================================================================
# Settings shared by all the Unix nodes involved in the 3.13 builds
# =================================================================


# Paths to local commands
# -----------------------

. "../nodes/$BBS_NODE_HOSTNAME/local-settings.sh"

# With StrictHostKeyChecking=no, ssh will automatically add new host keys
# to the user known hosts files (so it doesn't get stalled waiting for an
# answer when not run interactively).
export BBS_SSH_CMD="$BBS_SSH_CMD -qi $BBS_RSAKEY -o StrictHostKeyChecking=no"
export BBS_RSYNC_CMD="$BBS_RSYNC_CMD -rl --delete --exclude='.svn' --exclude='.git' --exclude='.github' --exclude='.git_*'"
export BBS_RSYNC_RSH_CMD="$BBS_RSYNC_CMD -e '$BBS_SSH_CMD'"

export BBS_R_CMD="$BBS_R_HOME/bin/R"
export BBS_RSCRIPT_CMD="$BBS_R_HOME/bin/Rscript"


# Variables specifying the version and mode of the current builds
# ---------------------------------------------------------------

export BBS_BIOC_VERSION="3.13"
export BBS_BIOC_GIT_BRANCH="master"
export BBS_BIOC_VERSIONED_REPO_PATH="$BBS_BIOC_VERSION/$BBS_SUBBUILDS"
export BBS_NON_TARGET_REPOS_FILE="$BBS_HOME/$BBS_BIOC_VERSIONED_REPO_PATH/non_target_repos.txt"

export BBS_CENTRAL_RUSER="biocbuild"
export BBS_CENTRAL_RDIR="/home/biocbuild/public_html/BBS/$BBS_BIOC_VERSIONED_REPO_PATH"
export BBS_CENTRAL_BASEURL="https://$BBS_CENTRAL_RHOST/BBS/$BBS_BIOC_VERSIONED_REPO_PATH"


# Define some environment variables to control the behavior of R
# --------------------------------------------------------------
export R_ENVIRON_USER="$BBS_HOME/$BBS_BIOC_VERSION/Renviron.bioc"

