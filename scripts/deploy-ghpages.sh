#!/usr/bin/env bash

# The prefix of the URL where new released files will be
URLSTUB='https://github.com/veo-ibd/veoibd-schemas/blob/gh-pages/'

git checkout master

# Find the last released tag version on the master branch.
newversion=$(git describe --tags --abbrev=0)
lastcommit=$(git rev-parse HEAD)
echo "Found release version ${newversion}, commit ${lastcommit}."

git checkout ${recent}

# Copy schema files to temporary directory
rm -rf pages-out || exit 0;
mkdir pages-out
cp schemas/*.json ./pages-out/

# Create new release files on gh-pages branch
git checkout gh-pages

if [ -d "assets/releases/${newversion}" ]
then
echo "Release ${newversion} directory exists, exiting.";
exit 1;
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

git push --force --quiet gh-pages:gh-pages
