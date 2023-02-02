#!/usr/bin/env bash

export SLING_PROJECT=$INPUT_PROJECT_ID
export SLING_API_KEY=$INPUT_API_KEY
export SLING_POOL=true
export SLING_LOADED_AT_COLUMN=true

if [ "$INPUT_VERSION" != "latest" ]; then
  # download sling version
  wget -q https://ocral.nyc3.cdn.digitaloceanspaces.com/slingdata.io/dist/$INPUT_VERSION/sling-linux
  mv sling-linux /usr/local/bin/sling
  chmod 755 /usr/local/bin/sling
fi

chmod -R 777 $GITHUB_WORKSPACE
cd $GITHUB_WORKSPACE

# run sling command
sh -c "sling $INPUT_COMMAND"