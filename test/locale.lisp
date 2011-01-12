(in-package :cl-locale-test)

(plan 0)


(deftest i18n
    (setf cl-test-more::*default-test-function* #'string=)
  (make-dictionary '(("Schedule" :ja-JP "予定" :fr-FR "Calendrier")))
  (setf *locale* :en-US)
  (is (i18n "Schedule") "Schedule" "en-US (default locale)")
  (setf *locale* :ja-JP)
  (is (i18n "Schedule") "予定" "ja-JP (default locale)")
  (is (i18n "Schedule" :locale :ja-JP) "予定" "ja-JP")
  (is (i18n "Schedule" :locale :fr-FR) "Calendrier" "fr-FR")
  )

(deftest load-dictionary
    (setf cl-locale::*dictionary* (make-hash-table :test 'equal))
  (load-dictionary (merge-pathnames #p"dictionary.lisp" *load-pathname*))
  (is (i18n "Lisping" :locale :ja-JP) "舌足らず"))

(run-test-all)
