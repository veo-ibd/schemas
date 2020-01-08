#!/usr/bin/env bash

# A script to deploy JSON schema files to a GitHub pages branch.
# This requires that GitHub releases are used, and deploys the most 
# recent tagged release. If the expected output directory already exists, 
# the script exits without modifying anything (releases will not be overwritten).

set -o errexit

# The prefix of the URL where new released files will be
URLSTUB='https://github.com/veo-ibd/veoibd-schemas/blob/gh-pages/'

git checkout master

# Find the last released tag version on the master branch.
newversion=$(git describe --tags --abbrev=0)
echo "Found release version ${newversion}, commit ${lastcommit}."

# Switch to the lastest released version to get the schema files
git checkout ${newversion}

# Last commit on this tag to build URL to
lastcommit=$(git rev-parse HEAD)

# Copy schema files to temporary directory
rm -rf pages-out || exit 0;
mkdir pages-out
cp schemas/*.json ./pages-out/

# Create new release files on gh-pages branch
git checkout gh-pages

if [ -d "assets/releases/${newversion}" ]
then
echo "Release ${newversion} directory exists, exiting.";
exit 0;
fi

mkdir assets/releases/${newversion}
cp ./pages-out/*.json assets/releases/${newversion}

printf "## ${newversion} ([view source](https://github.com/veo-ibd/veoibd-schemas/tree/${lastcommit}))\n\n" > pages-out/tmp-index.md

thefiles=$(find assets/releases/${newversion} -name "*.json")
for f in ${thefiles} ; do
    echo "- [${f}](assets/releases/${newversion}/${f})" >> pages-out/tmp-index.md ;
done

# Build new index.md
head -n 2 index.md > pages-out/new-index.md
cat pages-out/tmp-index.md >> pages-out/new-index.md
tail -n +2 index.md >> pages-out/new-index.md
cp pages-out/new-index.md index.md

git add assets/releases/${newversion}
git add index.md

git commit -m "Deployed new release ${newversion} to Github Pages"

# git push --force --quiet --upstream gh-pages
