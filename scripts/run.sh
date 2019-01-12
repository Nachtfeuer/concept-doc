#!/bin/bash
set -euo pipefail
PROMPT="run.sh :: "

case $1 in
    tests)
         ;;

    html)
        mkdir -p build
        echo "${PROMPT}Generating build/documentation.html ..."
        python scripts/transform.py --xml documentation.xml --xsl documentation.xsl --out build/documentation.html
        ;;
esac
