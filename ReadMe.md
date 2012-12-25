Gist Wizard
===========

Download all gists for a given user, storing them in a folder named after gist id.
Symlink a friendly name to this folder if known.

Usage:

    bundle exec foreman run bin/gistwiz down

Note that foreman injects the environment variables from your local (gitignored) `.env` file, which should look something like:

    GITHUB_USER=username
    GITHUB_PASS=password
    GISTS_BY_ID_DIR="/Users/joe/gists/by_id"
    GISTS_BY_NAME_DIR="/Users/joe/gists/by_name"

