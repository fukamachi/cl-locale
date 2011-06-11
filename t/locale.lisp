(in-package :cl-user)
(defpackage cl-locale-test
  (:use :cl
        :cl-locale
        :cl-locale-syntax
        :cl-syntax
        :cl-test-more))
(in-package :cl-locale-test)

(use-syntax cl-locale-syntax)

(plan 5)

(setf *dictionary-tables* (make-hash-table :test 'equal))
(setf *locale* :en-US)

(define-dictionary schedule
  (:ja-JP '(("Schedule" . "予定")))
  (:fr-FR '(("Schedule" . "Calendrier"))))

(is (i18n "Schedule") "Schedule" "en-US (default locale)")

(setf *locale* :ja-JP)

(is (i18n "Schedule") "予定" "ja-JP (default locale)")
(is (i18n "Schedule" :locale :ja-JP) "予定" "ja-JP")
(is (i18n "Schedule" :locale :fr-FR) "Calendrier" "fr-FR")

(define-dictionary lisp
  (:ja-JP (asdf:system-relative-pathname
           :cl-locale
           #p"t/i18n/ja_JP.lisp"))
  (:fr-FR (asdf:system-relative-pathname
           :cl-locale
           #p"t/i18n/fr_FR.lisp")))

(is (i18n "Lisping" :locale :ja-JP) "舌足らず" "load from file")

(is #i"Lisping" "舌足らず")

(finalize)
