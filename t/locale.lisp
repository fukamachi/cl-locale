(in-package :cl-user)
(defpackage cl-locale-test
  (:use :cl
        :cl-locale
        :cl-syntax
        :prove))
(in-package :cl-locale-test)

(use-syntax :locale-syntax)

(plan 8)

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

(let ((jp-mean
       (flex:octets-to-string #(232 136 140 232 182 179 227 130 137 227 129 154)
        :external-format :utf-8)))
  (is (i18n "Lisping" :locale :ja-JP)
      jp-mean
      "load from file")
  (is #i"Lisping" jp-mean "with reader macro"))
(let ((jp-mean
       (flex:octets-to-string #(67 111 109 109 111 110 32 227 130 138 227 129 153 227 129 183)
        :external-format :utf-8)))
  (is (i18n "~A Lisp" :params '("Common") :locale :ja-JP) jp-mean
      "format-control string")
  (is #i("~A Lisp" "Common") jp-mean
      "format-control string with reader macro"))

(finalize)
