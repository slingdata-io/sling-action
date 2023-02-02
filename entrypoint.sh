#!/usr/bin/env bash

export SLING_PROJECT=$INPUT_PROJECT_ID
export SLING_API_KEY=$INPUT_API_KEY
export SLING_POOL=true
export SLING_LOADED_AT_COLUMN=true

env > /tmp/.env

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" --env-file /tmp/.env --entrypoint=sh slingdata/sling:$INPUT_VERSION -c "sling $INPUT_COMMAND"
