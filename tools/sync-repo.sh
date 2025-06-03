#!/bin/bash

# This script assumes that kubernetes/kubernetes is already checked out as a remote named upstream pointing to
# https://github.com/kubernetes/kubernetes.git. Running this script will:
# 1. Set a remote called security to kubernetes-security/kubernetes.
# 2. Discover the branches which need synced which includes the master branch and all currently supported release branches.
# 3. Checkout each of the upstream branches locally requiring syncing and push them to the corresponding security branches.
# Example usage:
# ./sync-repo.sh <path-to-kubernetes-repo>

set -e
kubernetes_dir=$1
if [ -z $kubernetes_dir ]; then
  echo "Pass argument for K8s directory: ./sync-repo.sh <kubernetes_dir>"
  exit 1
fi

pushd "$kubernetes_dir"
# Confirm that the given repo has a remote named upstream. Grep will fail with a non-zero exit code which will cause
# the script to exit if this remote doesn't exist.
git remote -v | grep 'upstream.*https://github.com/kubernetes/kubernetes.git' > /dev/null

git remote add security https://github.com/kubernetes-security/kubernetes.git || true
echo "Fetching from security and upstream remotes"
git fetch security
git fetch upstream

# Checkout rules.yaml from upstream/master so that release branches are up-to-date
git checkout upstream/master -- staging/publishing/rules.yaml
sync_branches_source="staging/publishing/rules.yaml"
sync_branches=$(cat $sync_branches_source | grep "branch:" | awk '{print $2;}'  | sort | uniq)

for branch in $sync_branches; do
  echo "*** Syncing branch $branch ***"
  # Check out the upstream branch locally
  git checkout -b tmp-sync upstream/$branch
  # Push to fork's release branch
  git push security tmp-sync:$branch
  # Delete after sync
  git checkout master
  git branch -D tmp-sync
  echo -e "Done syncing branch $branch\n"
done

popd