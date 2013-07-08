Gist Wizard
===========

Install 
-------
            
    git clone https://github.com/harlantwood/gist-wizard.git
    cd gist-wizard
    bundle install
    
Add the gist-wizard/bin directory to your $PATH.
Then you can run it from anywhere, and it will
clone gists into a subdirectory of your current working dir.

Sync all your gists to your local machine
-----------------------------------------

    gwiz down

Will download all public and private gists for the user given by the 
environment variables `GITHUB_USER` and `GITHUB_PASS`.

Gists will be stored in 
`gists/by_id/<Gist ID>`.

A "friendly" name will be generated if possible, and a symlink created in 
`gists/by_name/<friendly name>`.
  
Both paths are relative the current working directory.

### For Example

After running from the home director, the directory `~/gists/by_id` might contain two folders:

    ~/681339/
    ~/4181294/

And the directory `~/gists/by_name`, two symlinks to these folders:

    Nahko-Bear-(Medicine-for-the-People)-ღ-Aloha-Ke-Akua-ღ@ -> ~/gists/by_id/4181294
    License-from-D3-by-Michael-Bostock----http:--mbostock.github.com-d3 -> ~/gists/by_id/1681339
    
Generate HTML for a Reveal.js slideshow
---------------------------------------

    gwiz reveal FILE

Where file is a filename or relative path to a file containing references to gists.

The gists listed in the file will be downloaded into `gists/by_id/`, and sample Reveal.js HTML will be written to STDOUT, eg:
                                                                                                   
    <section data-markdown="gists/by_id/0771ce3b37a74dad4588/An-architecture-for-a-distributed-autonomous-node-network.md" data-separator="^\n\n\n" data-vertical="^\n\n"></section>
    <section data-markdown="gists/by_id/86fa6f17e60229b6f636/Address Spaces of Hashes and Other Names.md" data-separator="^\n\n\n" data-vertical="^\n\n"></section>

Notes
-----

* Alpha quality script, created for personal use; set free in the hope it may help others.
* Please fork as inspired; pull requests are welcome.

License
-------

<a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" /></a>

To the extent possible under law, Harlan T Wood has waived all copyright and related or neighboring rights to this work.
