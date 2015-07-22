#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale.syntax
  (:use :cl)
  (:import-from :cl-locale.reader
                :locale-syntax-reader)
  (:export :locale-syntax))
(in-package :cl-locale.syntax)

(syntax:defsyntax locale-syntax
  (:merge :standard)
  (:dispatch-macro-char #\# #\i #'locale-syntax-reader)
  (:dispatch-macro-char #\# #\l #'l10n-reader))
