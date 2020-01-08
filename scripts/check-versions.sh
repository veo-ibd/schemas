#!/usr/bin/env bash

currversion=$(cat VERSION)
find . -name \*.json | xargs -I {} python scripts/check-json-versions.py -q --version ${currversion} {}
