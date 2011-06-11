#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale-syntax
  (:use :cl
        :cl-syntax)
  (:import-from :cl-locale.reader
                :locale-syntax-reader)
  (:export :locale-syntax))
(in-package :cl-locale-syntax)

(defsyntax locale-syntax
  (:dispatch-macro-character #\# #\i #'locale-syntax-reader))
