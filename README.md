[![Build Status](https://travis-ci.com/veo-ibd/veoibd-schemas.svg?branch=master)](https://travis-ci.com/veo-ibd/veoibd-schemas)

# schemas
JSON schemas for VEO-IBD data submission

## Instructions

### Updating the schemas

The schemas themselves are stored in [schemas/](schemas/). These can be updated using pull requests.

The JSON files are linted on each commit and pull request through Travis.

### Publishing a new version of the schemas

This repository has GitHub pages enabled on the `gh-pages` branch.

1. Get a copy of the files in the [schema/](schema/) directory outside of the repository.
1. Switch to the `gh-pages` branch.
1. Make a new directory (named via semantic versioning) in [docs/assets/releases/](docs/assets/releases/) for the new published schema version.
1. Move the files you copied from [schema/](schema/) into the new publishing directory.
1. Update the `index.md` with links to the files in the new release folder, including a link to the commit tree for the master branch at the time that you did the copy.
