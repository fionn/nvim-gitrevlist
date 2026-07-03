# Git Revision List Filetype Plugin

A Git revision list is (from `git help fsck`'s `fsck.skipList` section)

> a list of object names (i.e. one unabbreviated SHA-1 per line)..., comments (#), empty lines, and any leading and trailing whitespace are ignored.

The default output of `git rev-list` will match this. It is also suitable as input to `git blame --ignore-revs-file`.

## Features

This plugin provides:
* syntax highlighting,
* commenting and uncommenting with default mappings `gc` and `gcc`,
* showing the commit on "hover" (`K`).

# Usage

1. Install this plugin.
2. Assign the filetype to the appropriate files, e.g.
   ```lua
   vim.filetype.add {
       extension = {
           ["git-blame-ignore-revs"] = "gitrevlist"
       }
   }
   ```
   for Neovim.
