# iadl -- Internet Archive collection DownLoader

This shell script makes it possible to download an entire collection from archive.org. It was originally
developed by @ghalfacree (https://github.com/ghalfacree/bash-scripts/blob/master/archivedownload.sh) but he
marked it as obsolete, because in the meantime the organisation behind Internet Archive developed an own
tool that allows downloading entire collections besides lot's of other things. So it's probably best to
look at their repository at https://github.com/jjjake/internetarchive.

However: collection downloading is all i need and i am not a big fan of python - i prefer a simple shell
script instead. Therefore i adopted and improved the original script and moved it to my own repository.

## Usage

    usage: iadl.sh [OPTIONS] <collection> <destination-dir>
    
    ARGUMENTS

        <collection>
            Name of collection to download files from. The collection name must
            be entered exactly as shown. See the archive.org entry page for the
            collection name.

        <destination-dir>
            The destination directory to download the files to.

    OPTIONS

        -A, --accept ACCEPT     Specify a comma-separated list of file name
                                suffixes or patterns to accept.
        -R, --reject REJECT     Specify a comma-separated list of file name
                                suffixes or patterns to reject.
        -h, --help              Display this usage information and exit.
            --version           Show version and exit.
        
## Acknowledgements

* The original script was written by Gareth Halfacree and released under the WTFPL -- https://github.com/ghalfacree/bash-scripts/issues/1
