#!/usr/bin/env bash

# init if .jj dir is not present
#
# if it is, we assume they probably have a configured working copy, so don't do
# anything.
if [ ! -d "$PWD/.jj" ]; then
  $PWD/buck/bin/extra/jj config set --user user.name  "$(git config --system user.name)"
  $PWD/buck/bin/extra/jj config set --user user.email "$(git config --system user.email)"
  $PWD/buck/bin/extra/jj config set --user ui.default-command log

  $PWD/buck/bin/extra/jj git init --colocate || true
  $PWD/buck/bin/extra/jj branch track main@origin
fi
