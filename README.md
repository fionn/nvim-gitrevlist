# Git Revision List Filetype Plugin

A Git revision list is

> a list of object names (i.e. one unabbreviated SHA-1 per line)..., comments (#), empty lines, and any leading and trailing whitespace are ignored.

(from Git's [`fsck.skipList`](https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt-fsckskipList) documentation).

The default output of `git rev-list` will match this. It is also suitable as input to `git blame --ignore-revs-file`.

## Features

This plugin provides:
* syntax highlighting,
* filetype detection for `.git-blame-ignore-revs` files,
* commenting and uncommenting with default mappings `gc` and `gcc`,
* showing the commit on "hover" (`K`).
