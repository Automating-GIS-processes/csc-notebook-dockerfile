#!/usr/bin/env bash

# whatever happens, start jupyter lab upon exit
trap "exec /usr/local/bin/start-notebook.sh $*" EXIT


# - get hold of ${YEAR} from the config file
# - check if ~/my-work exists
# - try to check out, except:
#    - stash and pull  (or fetch?)
# - then juptext!

echo "testing that this is being run, indeed"

# read YEAR from the file to which `docker build` saved it
YEAR="$(<~/.autogis-year)"



