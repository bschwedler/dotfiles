#!/bin/bash
set -e
set -o pipefail

ERRORS=()

# find all executables and run `shellcheck`
for f in $(./files.sh) ; do
	{
		shellcheck "$f" && echo "[OK]: sucessfully linted $f"
	} || {
		# add to errors
		ERRORS+=("$f")
	}
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
