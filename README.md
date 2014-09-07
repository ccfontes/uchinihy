uchinihy
========
In-house scripts in Hy

### Crafting
-------
Maybe use the code as examples for your own scripts because they aren't sufficiently generalized.

### What's in the house?
-------
<b>is-cljs-modified.hy</b> <em>Verifies if the Clojurescript sources were modified since last build.</em>

<b>readme-append.hy</b> <em>Formats lein-notes and then appends them to README.md</em>

<b>cljs.hy</b> <em>Runs 'lein cljsbuild auto' (non blocking) when there are changes in the cljs files. Accepts other commands as arguments to execute after the daemon is launched. Example: 'script/with/cljs lein run' (script has problems with messages printing to several terminals)</em>

### License
-------
Copyright (C) 2014 Carlos C. Fontes.

Licensed under the
[MIT License](http://opensource.org/licenses/MIT).
