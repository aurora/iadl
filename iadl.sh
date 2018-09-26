#!/usr/bin/env bash

#
# This shell script makes it possible to download an entire collection from archive.org.
# Please have a look at the repository at https://github.com/aurora/iadl for details and
# for license and copyright information.
#

if [ "$3" = "" ]; then
    echo "usage: iadl.sh <collectionname> <extensions> <destination-dir>"
    echo
    echo "  <collection>"
    echo "      Name of collection to download files from. The collection name must"
    echo "      be entered exactly as shown. See the archive.org entry page for the"
    echo "      collection name."
    echo
    echo "  <extensions>"
    echo "      Comma-separated list of accepted file extensions."
    echo
    echo "  <destination-dir>"
    echo "      The destination directory to download the files to."
    echo
    exit 1
fi

if [ ! -d "$3" ]; then
    echo "Destination directory does not exist."
    exit 1
fi

cd "$3"

echo "Downloading list of entries for collection name $1 ..."

tmp=$(mktemp 2>/dev/null || mktemp -t "tmp.XXXXXXXXXX")

wget -O - -nd -q "https://archive.org/advancedsearch.php?q=$1&fl%5B%5D=identifier&sort%5B%5D=identifier+asc&sort%5B%5D=&sort%5B%5D=&rows=9999&page=1&callback=callback&save=yes&output=csv" 2>/dev/null \
    | tail -n +2 \
    | sed 's/"//g' > $tmp

if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "Error downloading identifiers."
    exit 1
fi

num=$(cat $tmp | wc -l)

if [ $num -eq 0 ]; then
    echo "No identifiers found for collection $1. Check name and try again."
    rm $tmp
    exit 1
fi

echo "Beginning wget download of $num identifiers ..."

wget -r -H -nc -nv -np -nH -nd -e robots=off \
    --domains archive.org --exclude-domains blog.archive.org \
    -i $tmp -B 'https://archive.org/download/' -A $2 2>&1 \
    | awk -v "ORS=" '{ print "."; fflush(); } END { print "\n" }'

if ls -U *_text.pdf > /dev/null 2>&1; then
    echo "Found text-format PDFs, moving into text/ directory ..."

    if [ ! -d text ]; then
        mkdir text
    fi

    mv *_text.pdf text/

    echo "Move complete."
fi

echo "Deleting temporary files ..."

rm $tmp

echo "Complete."
