"""Check versions inside JSON schema files.

These can be in '$id' and '$ref' fields.

Our URLs come from GitHub, but this only uses the format of the relative path.
The last directory in the path should be named with the release version.

For example, a URL like:

https://veo-ibd.github.io/veoibd-schemas/assets/releases/v0.0.3-dev/veoibd_individual_schema.json

has a path of "/veoibd-schemas/assets/releases/v0.0.3-dev/", and  release
'v0.0.3-dev' is the final directory.

"""

import json
import os
import requests
import urllib

def check_versions(url, version):
    """Check version of all '$ref's in the properties of a JSON file.

    Returns a dictionary where the version does not match.
    The keys are the property name, and the value is the current version.

    """

    jsonfile = requests.get(url)
    schema = jsonfile.json()
    
    non_matching = {}

    for key in schema['properties']:
        try:
            ref = schema['properties'][key]['$ref']
        except KeyError:
            continue

        res = urllib.parse.urlparse(ref)
        mypath = os.path.split(res.path)[0]
        curr_version = os.path.split(mypath)[1]

        if curr_version != version:
            non_matching[key] = curr_version

    return non_matching

def main():
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("url", type=str)
    parser.add_argument("--version", type=str)
    parser.add_argument("-q", "--quiet", action="store_true")
    args = parser.parse_args()

    res = check_versions(args.url, args.version)
    
    if res:
        raise ValueError("Version number {version} does not match refs for: {res}.".format(res=res, version=args.version))
    
    if not args.quiet:
        print("All version numbers match.")

if __name__ == "__main__":
    main()
