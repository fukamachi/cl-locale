#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale.reader
  (:use :cl
        :cl-syntax
        :cl-locale.core))
(in-package :cl-locale.reader)

(use-syntax :annot)

(defun locale-syntax-reader (stream char numarg)
  (declare (ignore char numarg))
  (let ((ch (peek-char t stream))
        (args (read stream)))
    (case ch
      (#\" `(i18n ,args))
      (#\( `(i18n ,(car args) :params (list ,@(cdr args))))
      (t (error "i18n reader must precede a list or a double-quoted string.: ~A" ch)))))

(defun l10n-reader (stream char numarg)
  (declare (ignore char numarg))
  `(l10n ,(read stream)))

(defun %enable-locale-syntax ()
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\i #'locale-syntax-reader)
  (set-dispatch-macro-character #\# #\l #'l10n-reader))

@export
(defmacro enable-locale-syntax ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-locale-syntax)))
