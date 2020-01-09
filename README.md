Branch | Status
--- | ---
Master | [![Build Status](https://travis-ci.com/veo-ibd/veoibd-schemas.svg?branch=master)](https://travis-ci.com/veo-ibd/veoibd-schemas)
Develop | [![Build Status](https://travis-ci.com/veo-ibd/veoibd-schemas.svg?branch=develop)](https://travis-ci.com/veo-ibd/veoibd-schemas)

# VEO-IBD data schemas

This repository is a registry of JSON schemas used for VEO-IBD data submission.

## Instructions

There are three long running branches in this repository: `master`, `develop`, and `gh-pages`. The `master` branch always has the most recent version of the schemas. All changes to the schemas should be made as pull requests against the `develop` branch. When a new version is ready, a pull request from `develop` to `master` should be made.

The repository has continuous integration set up using Travis CI. JSON linting is performed on all pull requests. Automated deployment to the publicly visible registry on the `gh-pages` branch (accessible at https://veo-ibd.github.io/veoibd-schemas/) is performed when merging `develop` to `master`. Read on below how to prepare for a new version release.

### Changing the schemas

The schemas themselves are stored in [schemas/](schemas/). These can be updated using pull requests against the `develop` branch.

The collection of schemas is versioned in the [VERSION](VERSION) file. It follows semantic versioning strategy. The rules for different version updates are still to be determined.

The JSON files are linted on each commit and pull request through Travis.

### Publishing a new version of the schemas

This repository has GitHub pages enabled on the `gh-pages` branch. Following these instructions will deploy schema files and update the index page with the most recent tagged release in this GitHub repository.

1. When a new release is ready, update the [`VERSION`](VERSION) file with the new version using semantic versioning (`vX.X.X`) on the develop branch.
1. Open, review, and merge a pull request from the `develop` branch to the `master` branch.
1. Check that Travis successfully ran the deployment (uses the [`bin/deploy-ghpages.sh`](bin/deploy-ghpages.sh) script).
1. Check that the new release is visible at the top of https://veo-ibd.github.io/veoibd-schemas/.
1. Create a new GitHub release from the master branch, named via the same as the version in the [`VERSION`](VERSION) file. Add any notes into the release that indicate what has changed.

## Development notes

All JSON files are linted on pull requests via Travis using `jsonlint` from the [demjson](https://github.com/dmeranda/demjson) package.

The deployment step ([`bin/deploy-ghpages.sh`](bin/deploy-ghpages.sh)) copies the current schema files in the [`schemas`](schemas/) directory into a new folder named after the version on the `gh-pages` branch in the `assets` folder. The `index.md` file is updated with links to the new versions of the schema, and all are added and pushed back to GitHub. This action requires a GitHub personal authentication token. This is set in Travis as an encrypted parameter (`GITHUB_TOKEN`).

If you wish to skip a deployment (e.g., for changes to the README file), prefix the head commit with `[ci skip]` to not trigger Travis when merging from `develop` to `master`. This can be accomplished by pushing an empty commit (`git commit --allow-empty -m "[ci skip] No Deployment"`)
