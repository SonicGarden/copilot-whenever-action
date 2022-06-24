#!/usr/bin/env bash

set -eux
cd "$(dirname "$0")"

bundle exec ruby ./exec_elastic_whenever.rb $1 $2 "$GITHUB_WORKSPACE/$3"
