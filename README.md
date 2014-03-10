homebrew-gh
===========

How do I install gh?
--------------------------------
Just `brew tap jingweno/gh` and then `brew install gh` (or `brew install jingweno/gh/gh`).

To build `gh` from source, type `brew install --build-from-source gh`.
You can also build from the latest head with `brew install --build-from-source --HEAD gh`.

If the formula conflicts with one from mxcl/master or another tap, you
can `brew install jingweno/gh/gh`.

You can also install via URL:

```
brew install https://raw.github.com/jingweno/homebrew-gh/master/gh.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki](http://wiki.github.com/mxcl/homebrew).
