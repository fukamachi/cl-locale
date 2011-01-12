(in-package :cl-locale-test)

(plan 5)

(deftest i18n
    (setf cl-test-more::*default-test-function* #'string=)
  (define-dictionary "sche" '(("Schedule" :ja-JP "予定" :fr-FR "Calendrier")))
  (setf *dictionary-name* "sche")
  (setf *locale* :en-US)

  (is (i18n "Schedule") "Schedule" "en-US (default locale)")
  (setf *locale* :ja-JP)
  (is (i18n "Schedule") "予定" "ja-JP (default locale)")
  (is (i18n "Schedule" :locale :ja-JP) "予定" "ja-JP")
  (is (i18n "Schedule" :locale :fr-FR) "Calendrier" "fr-FR")

  (define-dictionary "lisp" (merge-pathnames #p"dictionary.lisp" *load-pathname*))
  (setf *dictionary-name* "lisp")
  (is (i18n "Lisping" :locale :ja-JP) "舌足らず" "load from file")
  )

(run-test-all)
