#!/usr/bin/env bash
set -e

export SLING_PROJECT=$INPUT_PROJECT_ID
export SLING_API_KEY=$INPUT_API_KEY

if [ "$INPUT_VERSION" != "latest" ]; then
  # download sling version
  echo "Downloading version $INPUT_VERSION"
  wget -q https://github.com/slingdata-io/sling-cli/releases/download/v$INPUT_VERSION/sling_linux_amd64.tar.gz
  rm -f sling
  tar -xf sling_linux_amd64.tar.gz
  rm -f /usr/local/bin/sling
  mv sling /usr/local/bin/sling
  chmod 755 /usr/local/bin/sling
fi

# chmod -R 777 $GITHUB_WORKSPACE
cd $GITHUB_WORKSPACE

# run sling command
sh -c "sling $INPUT_COMMAND"
