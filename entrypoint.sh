#!/usr/bin/env bash

set -eux

bundle exec ruby /action/exec_elastic_whenever.rb $1 $2 "$GITHUB_WORKSPACE/$3"
