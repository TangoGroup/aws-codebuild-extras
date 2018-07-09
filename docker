#!/bin/sh

CLEAN_BRANCHES="$CODEBUILD_GIT_CLEAN_BRANCHES"
GIT_TS="$CODEBUILD_GIT_TIMESTAMP"
GIT_SHA="$CODEBUILD_GIT_SHORT_COMMIT"
SUFFIX="-${GIT_TS}-${GIT_SHA}"

BRANCH_TAGS="$(echo "$CLEAN_BRANCHES" | sed "s|\$|$SUFFIX|g")"

DOCKER_TAGS="$BRANCH_TAGS"

export DOCKER_TAGS="$GIT_SHA\n$DOCKER_TAGS"
export DOCKER_PULL_TAGS="$GIT_SHA\n$CLEAN_BRANCHES"

if [ "${CODEBUILD_PULL_REQUEST}" != "false" ]; then
  PR="pr.$CODEBUILD_PULL_REQUEST";
  DOCKER_TAGS="$PR\n$PR$SUFFIX\n$DOCKER_TAGS";
fi

# if $CODEBUILD_SOURCE_VERSION is -equal- to a branch that points at this current commit
if [ "$(echo "$CODEBUILD_GIT_BRANCHES" | grep -o -E -e "^$CODEBUILD_SOURCE_VERSION$" )" != "" ]; then
  CLEAN_CODEBUILD_SOURCE_VERSION="$(echo "$CODEBUILD_SOURCE_VERSION" | tr '/' '.')";
  export COMMIT_TAG="${CLEAN_CODEBUILD_SOURCE_VERSION}-${CODEBUILD_GIT_TIMESTAMP}-${CODEBUILD_GIT_SHORT_COMMIT}";
# or there is only one branch that points at this current commit (for PRs...?)
elif [ "$(echo -n "$CLEAN_BRANCHES" | sed "/^$/d" | wc -l)" -eq 1 ]; then
  export COMMIT_TAG="${CODEBUILD_GIT_CLEAN_BRANCH}-${CODEBUILD_GIT_TIMESTAMP}-${CODEBUILD_GIT_SHORT_COMMIT}";
# else use the short git commit SHA
else
  export COMMIT_TAG="${CODEBUILD_GIT_SHORT_COMMIT}"
fi

echo "==> AWS CodeBuild Docker Environment Variables:"
echo "==> DOCKER_TAGS = $DOCKER_TAGS"
echo "==> DOCKER_PULL_TAGS = $DOCKER_PULL_TAGS"
echo "==> COMMIT_TAG = $COMMIT_TAG"
