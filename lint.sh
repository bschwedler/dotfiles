#!/bin/bash

# find all executables and run `shellcheck`
$(find . -type f -not -iwholename '*.git*' -not -iwholename './utils/*' -not -name "yubitouch.sh" | sort -u)
