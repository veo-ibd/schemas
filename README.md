[![Build Status](https://travis-ci.com/veo-ibd/veoibd-schemas.svg?branch=master)](https://travis-ci.com/veo-ibd/veoibd-schemas)

# schemas
JSON schemas for VEO-IBD data submission

## Instructions

### Updating the schemas

The schemas themselves are stored in [schemas/](schemas/). These can be updated using pull requests.

The JSON files are linted on each commit and pull request through Travis.

### Publishing a new version of the schemas

This repository has GitHub pages enabled on the `gh-pages` branch. Following these instructions will deploy schema files and update the index page with the most recent tagged release in this GitHub repository.

1. Create a new GitHub release on the master branch, named via semantic versioning (`vX.X.X`). If this is a development release, name it with a `-devX` suffix.
1. On your local machine, make sure that you are on the master branch and run `git fetch` or otherwise make sure you have the most recent remote changes.
1. Run the script at [`scripts/deploy-ghpages.sh`](scripts/deploy-ghpages.sh)
