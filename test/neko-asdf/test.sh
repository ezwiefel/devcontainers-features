#!/bin/bash

set -e

source dev-container-features-test-lib

check "neko -version" neko -version

reportResults
