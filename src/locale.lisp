#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale
  (:use :cl
        :cl-syntax)
  (:import-from :arnesi
                :aif
                :aand
                :it))
(in-package :cl-locale)

(use-syntax cl-syntax-annot:annot-syntax)

@export
(defvar *default-locale* :en-US)
@export
(defvar *locale* nil)
@export
(defvar *locales* nil)
@export
(defvar *dictionary-name* nil)
@export
(defvar *dictionaries* (make-hash-table :test 'equal))

@export
(defmethod define-dictionary (name (dict cons))
  (loop with hash = (make-hash-table :test 'equal)
        for (word . plist) in dict
        do (setf (gethash word hash) plist)
           (loop for locale in plist by #'cddr do (pushnew locale *locales*))
        finally (setf (gethash name *dictionaries*) hash)))

(defun slurp-stream (stream)
  (let ((seq (make-string (file-length stream))))
    (read-sequence seq stream)
    seq))

@export
(defmethod define-dictionary (name (dict pathname))
  (with-open-file (stream dict)
    (define-dictionary name (read-from-string (slurp-stream stream)))))

@export
(defun i18n (string &key (locale *locale*) (dictionary *dictionary-name*))
  (or (aand (not (eq locale *default-locale*))
            (gethash dictionary *dictionaries*)
            (gethash string it)
            (getf it locale))
      string))
