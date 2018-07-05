#!/bin/sh

CLEAN_BRANCHES="$CODEBUILD_GIT_CLEAN_BRANCHES"
GIT_TS="$CODEBUILD_GIT_TIMESTAMP"
GIT_SHA="$CODEBUILD_GIT_SHORT_COMMIT"
SUFFIX="-${GIT_TS}-${GIT_SHA}"

BRANCH_TAGS="$(echo "$CLEAN_BRANCHES" | sed "s|\$|$SUFFIX|g")"

DOCKER_TAGS="$BRANCH_TAGS"

export DOCKER_TAGS="$GIT_SHA\n$DOCKER_TAGS"
export DOCKER_PULL_TAGS="$GIT_SHA\n$CLEAN_BRANCHES"


# if $CODEBUILD_SOURCE_VERSION is not a git hash
# and is equal to a branch that points at this current commit, 
# tag it like this!:
export COMMIT_TAG="${CODEBUILD_GIT_CLEAN_BRANCH}-${CODEBUILD_GIT_TIMESTAMP}-${CODEBUILD_GIT_SHORT_COMMIT}"
# otherwise, set COMMIT_TAG to $GIT_SHA

echo "==> AWS CodeBuild Docker Environment Variables:"
echo "==> DOCKER_TAGS = $DOCKER_TAGS"
echo "==> DOCKER_PULL_TAGS = $DOCKER_PULL_TAGS"
echo "==> COMMIT_TAG = $COMMIT_TAG"
