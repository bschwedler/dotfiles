workflow "Tests" {
  on = "push"
  resolves = ["Shellcheck"]
}

action "Shellcheck" {
   uses = "actions/bin/shellcheck@master"
   args = "$(lint.sh)"
 }
