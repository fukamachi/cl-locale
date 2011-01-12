(in-package :cl-user)

(defpackage cl-locale-asd
  (:use :cl :asdf))

(in-package :cl-locale-asd)

(defsystem cl-locale
  :version "0.1"
  :author "Eitarow Fukamachi"
  :license "LLGPL"
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "special")
                             (:file "locale")))))
