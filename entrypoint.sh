#!/usr/bin/env bash

export SLING_PROJECT=$INPUT_PROJECT_ID
export SLING_API_KEY=$INPUT_API_KEY
export SLING_POOL=true
export SLING_LOADED_AT_COLUMN=true

cp -r $GITHUB_WORKSPACE /tmp/work

echo "INPUT_PROJECT_ID=$INPUT_PROJECT_ID"

env > /tmp/work/.env

ls -l /tmp/work

echo ' >>> step >>>'

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" -v /tmp/work:/sling-work -w /sling-work --env-file /tmp/work/.env --entrypoint=sh slingdata/sling:$INPUT_VERSION -c "ls -l /"
