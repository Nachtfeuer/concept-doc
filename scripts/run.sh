#!/bin/bash
set -euo pipefail
PROMPT="run.sh :: "

case $1 in
    prepare)
        if [ ! -d tools ]; then
            mkdir -p tools
        else
            echo "${PROMPT}tools folder already exists"
        fi

        if [ ! -f tools/saxon-he.zip ]; then
            echo "${PROMPT}Installing Saxon HE ..."
            wget -q https://sourceforge.net/projects/saxon/files/Saxon-HE/9.9/SaxonHE9-9-0-2J.zip/download -Otools/saxon-he.zip
            pushd tools
            unzip saxon-he.zip
            popd
        else
            echo "${PROMPT}Saxon HE already installed"
        fi
        ;;

    html)
        mkdir -p build
        echo "${PROMPT}Generating build/documentation.html ..."
        java -jar tools/saxon9he.jar -s:documentation.xml -xsl:documentation.xsl -o:build/documentation.html
        ;;
esac
