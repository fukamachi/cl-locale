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
(defpackage cl-locale-asd
  (:use :cl :asdf))
(in-package :cl-locale-asd)

(defsystem cl-locale
  :version "0.1"
  :author "Eitarow Fukamachi"
  :depends-on (:anaphora
               :arnesi
               :cl-annot
               :cl-syntax
               :cl-syntax-annot)
  :license "LLGPL"
  :components ((:module "src"
                :serial t
                :components ((:file "locale"))))
  :description "Simple i18n library for Common Lisp"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :direction :input)
      (let ((seq (make-array (file-length stream)
                             :element-type 'character
                             :fill-pointer t)))
        (setf (fill-pointer seq) (read-sequence seq stream))
        seq)))
