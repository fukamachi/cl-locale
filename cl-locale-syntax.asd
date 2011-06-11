#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

#|
  CL-Locale is a simple i18n library for Common Lisp.

  Author: Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-locale-syntax-asd
  (:use :cl :asdf))
(in-package :cl-locale-syntax-asd)

(defsystem cl-locale-syntax
  :version "0.1"
  :author "Eitarow Fukamachi"
  :depends-on (:cl-locale
               :cl-syntax)
  :license "LLGPL"
  :components ((:module "src"
                :components ((:file "syntax")))))
