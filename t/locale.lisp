(in-package :cl-user)
(defpackage cl-locale-test
  (:use :cl
        :cl-locale
        :cl-syntax
        :prove))
(in-package :cl-locale-test)

(named-readtables:in-readtable locale-syntax)

(plan 13)

(setf *dictionary-tables* (make-hash-table :test 'equal))
(setf *locale* :en-US)

(define-dictionary schedule
  (:ja-JP '(("Schedule" . "予定")
            ("date-format" . (:year "." :month "." :day))))
  (:fr-FR '(("Schedule" . "Calendrier")
            ("date-format" . (:day "-" :month "-" :year)))))

(is (i18n "Schedule") "Schedule" "en-US (default locale)")

(setf *locale* :ja-JP)

(is (i18n "Schedule") "予定" "ja-JP (default locale)")
(is (i18n "Schedule" :locale :ja-JP) "予定" "ja-JP i18n")
(is (i18n "Schedule" :locale :fr-FR) "Calendrier" "fr-FR i18n")

(is (i18n-unformatted "date-format") '(:year "." :month "." :day))
(is (i18n-unformatted "date-format" :locale :ja-JP) '(:year "." :month "." :day) "ja-JP i18n-unformatted")
(is (i18n-unformatted "date-format" :locale :fr-FR) '(:day "-" :month "-" :year) "fr-FR i18n-unformatted")

(define-dictionary lisp
  (:ja-JP (asdf:system-relative-pathname
           :cl-locale
           #p"t/i18n/ja_JP.lisp"))
  (:fr-FR (asdf:system-relative-pathname
           :cl-locale
           #p"t/i18n/fr_FR.lisp")))

(let ((jp-mean
       (flex:octets-to-string #(232 136 140 232 182 179 227 130 137 227 129 154)
        :external-format :utf-8))
      (jp-format '(:year "." :month "." :day)))
  (is (i18n "Lisping" :locale :ja-JP)
      jp-mean
      "i18n load from file")
  (is #i"Lisping" jp-mean "i18n with reader macro")

  (is (i18n-unformatted "date-format" :locale :ja-JP)
      jp-format
      "i18n-unformatted load from file")
  (is #l"date-format" jp-format "i18n-unformatted with reader macro"))

(let ((jp-mean
       (flex:octets-to-string #(67 111 109 109 111 110 32 227 130 138 227 129 153 227 129 183)
        :external-format :utf-8)))
  (is (i18n "~A Lisp" :params '("Common") :locale :ja-JP) jp-mean
      "format-control string")
  (is #i("~A Lisp" "Common") jp-mean
      "format-control string with reader macro"))

(finalize)
