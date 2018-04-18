## dotfiles

Layout and inspiration from [github.com/jessfraz/dotfiles](https://github.com/jessfraz/dotfiles)

**To install:**

```console
$ make
```

This will create symlinks from this repo to your home folder.

**To customize:**

The configuration here uses the `~/.gitlocal` file to store the name
and email of the git user.  This simplifies the process of keeping
system-level configuration changes in `~/.gitconfig`.
If you would rather have this configuration in the global git config,
Be sure to uncomment the relevant line in the Makefile to ensure that
credentials are not commited inadvertently.

Save env vars, etc in a `.extra` file, that looks something like
this:

```bash
###
### Git credentials
###

GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --file ~/.gitlocal user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="email@you.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --file ~/.gitlocal user.email "$GIT_AUTHOR_EMAIL"
GH_USER="nickname"
git config --file ~/.gitlocal github.user "$GH_USER"

```

### Tests

The tests use [shellcheck](https://github.com/koalaman/shellcheck). You don't
need to install anything. They run in a container.

```console
$ make test
```
