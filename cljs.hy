#!/usr/bin/env hy
; Author: <Carlos C. Fontes> ccfontes@gmail.com

(import [sh [touch ls lein sleep]]
        [glob [glob]]
        sys
        [subprocess [call Popen PIPE STDOUT]]
        [thread [start_new_thread]])

(defn with-print-call [exe]
  (let [[p (apply Popen [exe] {"stdout" PIPE "stderr" STDOUT})]]
    (print "p " p)
    (print "(.poll p) " (.poll p))
    (while true
      (sleep 2)
      (if-not (.poll p) (continue))
      (print p.stdout.readline))))

(defn what-last-modified-file []
  (->> "src-cljs/app/*.cljs"
       glob
       (ls "-t" "resources/public/js/main.js")
       .split
       first))

(defn cljs-watcher []
  (while true
    (if (= "cljs" (-> (what-last-modified-file) (.split ".") .pop))
        (with-print-call ["lein" "cljsbuild" "auto"])
          (sleep 2))
    (sys.stdout.flush)))

(start_new_thread cljs-watcher (,))

(-> sys.argv rest call)
