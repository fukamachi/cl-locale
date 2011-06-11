(in-package :cl-user)

(defpackage cl-locale-test-asd
  (:use :cl :asdf))

(in-package :cl-locale-test-asd)

(defsystem cl-locale-test
  :depends-on (:cl-locale
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "locale")))))
