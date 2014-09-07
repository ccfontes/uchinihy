#!/usr/bin/env hy
; Author: <Carlos C. Fontes> ccfontes@gmail.com

(import [sh [cat lein echo tee rm]])
(import [script.hy-lib.hyclops.hyclops [comp]]) ; you must provide this your own

(setv irrelevant-note-patterns
  ["/.repl/" "/out/" "/README.md" "/target/" "/script/hy_lib/"])

(defn irrelevant-note?
;  FIXME docstring not working for some unknown reason
;  "Checks if note regards to this project, according to
;   a list of irrelevant patterns corresponding to paths."
  [note]
  (-> (fn [patt] (!= (.find note patt) -1))
      (filter irrelevant-note-patterns)
      list
      empty?
      not))

(setv notes-start
  (+ "### Notes\n"
     "\n"
     "Maybe you want to take care of this pile of work first, "
     "before adding more stuff to the pile:\n"
     "```\n"))


(setv complete-str
  (let [[get-relevant-path (comp second (fn [this] (.split this "/heriti/")))]]
    (+ (-> "README-base.md" cat str)
       notes-start
       (->> "notes" lein str
            .splitlines
            (remove irrelevant-note?) list
            (map get-relevant-path)
            (.join "\n"))
       "```\n")))

(tee (echo complete-str) "README.md")
