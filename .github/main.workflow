workflow "Tests" {
  on = "push"
  resolves = ["Shellcheck"]
}

action "Shellcheck" {
   uses = "actions/bin/shellcheck@master"
   args = "$(find . -type f -not -iwholename '*.git*' -not -iwholename './utils/*' | sort -u)"
 }
