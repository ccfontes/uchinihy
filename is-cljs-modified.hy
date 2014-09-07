#!/usr/bin/env hy
; Author: <Carlos C. Fontes> ccfontes@gmail.com

(defn cljs-modified?
  """Verifies if the Clojurescript sources were modified since last build."""
  []
  (let [ls-by-time-modified (partial ls "-t")]
    (-> (glob "src-cljs/app/*.cljs")
        (ls-by-time-modified "resources/public/js/main.js")
        .split
        first
        (.split ".")
        .pop
        (= "cljs"))))

(if-not (cljs-modified?)
  (sys.exit 1))
