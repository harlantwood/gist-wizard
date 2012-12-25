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

After running with this config, the directory `/Users/joe/gists/by_id` might contain two folders:

    1681339
    4181294

And the directory `/Users/joe/gists/by_name`, two symlinks to these folders:

    Nahko-Bear-(Medicine-for-the-People)-ღ-Aloha-Ke-Akua-ღ@ -> /Users/joe/gists/by_id/4181294
    License-from-D3-by-Michael-Bostock----http:--mbostock.github.com-d3- -> /Users/harlan/HKB/gists/by_id/1681339

Notes
-----

* This is a simple script created for my own usage, and set free in the hope it may help others.
* Please fork it as inspired; pull requests are welcome.

License
-------

<a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" /></a>

To the extent possible under law, Harlan T Wood has waived all copyright and related or neighboring rights to this work.