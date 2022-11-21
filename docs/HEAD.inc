---
layout: page
title: DIFF TOOLS
---

This repository includes diff related tools including `sdif`, `cdif`,
and `watchdiff` commands.  These works as a post-processor for `diff`
command to support visualizing the output.

They can be used along with `git` command and provide convenient
output for ANSI color terminals.

`sdif` and `cdif` are tuned to handle Asian multi-byte characters,
especially Japanese text.  There are some other tools which provide
similar capability, but most of them are not appropriate to process
document data.  `cdif` provide word-by-word difference rather than
character-by-character, which make the output much easy to read.  It
also support a `mecab` command as a syllable tokenizer.


## CONTENTS

### Tools

- [sdif](./sdif)
- [cdif](./cdif)
- [watchdiff](./watchdiff)

### [Images](./images)

### Repository

- [https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

