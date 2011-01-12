(in-package :cl-locale-test)

(plan 4)

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
  )

(run-test-all)
