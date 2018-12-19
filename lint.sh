#!/bin/bash

# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' -not -iwholename './utils/*' -not -name "yubitouch.sh" | sort -u); do
    if file "$f" | grep --quiet shell; then
        echo $f
    fi
done
