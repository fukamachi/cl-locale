(in-package :cl-user)

(defpackage cl-locale-test-asd
  (:use :cl :asdf))

(in-package :cl-locale-test-asd)

(defsystem cl-locale-test
  :depends-on (:cl-locale :cl-test-more)
  :components ((:module "test"
                :serial t
                :components
                ((:file "locale")))))
