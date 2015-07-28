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

@export
(defun i18n-reader (stream char numarg)
  (declare (ignore char numarg))
  (let ((ch (peek-char t stream))
        (args (read stream)))
    (case ch
      (#\" `(i18n ,args))
      (#\( `(i18n ,(car args) :params (list ,@(cdr args))))
      (t (error "i18n reader must precede a list or a double-quoted string.: ~A" ch)))))

@export
(defun i18n-unformatted-reader (stream char numarg)
  (declare (ignore char numarg))
  `(i18n-unformatted ,(read stream)))

(defun %enable-locale-syntax ()
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\i #'i18n-reader)
  (set-dispatch-macro-character #\# #\l #'i18n-unformatted-reader))

@export
(defmacro enable-locale-syntax ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-locale-syntax)))
