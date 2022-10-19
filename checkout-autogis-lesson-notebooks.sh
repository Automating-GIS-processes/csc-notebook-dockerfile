#!/usr/bin/env bash

# whatever happens, start jupyter lab upon exit
trap "exec /usr/local/bin/start-notebook.sh $*" EXIT

AUTOGIS_NOTEBOOKS="https://github.com/Automating-GIS-processes/notebooks.git"
git clone "${AUTOGIS_NOTEBOOKS}"
