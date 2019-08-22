# Running from Vagrant

## Log into the machine
`vagrant ssh`

## Launching the local Jekyll site

Use the `--force_polling` flag to work around the issue where the blog doesn't automatically update locally.

`bundle exec jekyll serve --force_polling`
