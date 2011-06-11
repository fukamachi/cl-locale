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

(use-syntax cl-syntax-annot:annot-syntax)

(defun read-lisp-string (input)
  "Parse a Lisp string. Expects “input” to point to the
  first character after the leading double quote.
  Slick version by Xach."
  (with-output-to-string (output)
    (loop
      (let ((char (read-char input)))
        (case char
          (#\\
           (setf char (read-char input)))
          (#\"
           (return)))
        (write-char char output)))))

(defun locale-syntax-reader (stream char arg)
  (declare (ignore arg char))
  (if (char= #\" (read-char stream))
      `(i18n ,(read-lisp-string stream))
      (error "i18n reader must precede a double-quoted string.")))

(defun %enable-locale-syntax ()
  (setf *readtable* (copy-readtable))
  (set-macro-character #\@ #'locale-syntax-reader))

@export
(defmacro enable-locale-syntax ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-locale-syntax)))
