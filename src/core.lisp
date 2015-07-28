#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale.core
  (:use :cl
        :cl-syntax
        :anaphora)
  (:shadowing-import-from :arnesi
                          :aand))
(in-package :cl-locale.core)

(use-syntax :annot)

@export
(defvar *default-locale* :en-US)
@export
(defvar *locale* *default-locale*)

(defvar *dictionary* nil)

@export
(defvar *dictionary-tables* (make-hash-table :test 'equal))

(defun ensure-hash-table (key hash)
  (sif (gethash key hash)
       it
       (progn
         (setf it (make-hash-table :test 'equal))
         it)))

(defun ensure-dictionary (name)
  (ensure-hash-table (string-upcase name) *dictionary-tables*))

@export
(defmethod register-dictionary (name (dict cons) &key (locale *locale*))
  "
Example:
  (register-dictionary :schedule
    '((\"Schedule\" . \"予定\"))
    :locale :ja-JP)
"
  (let* ((dict-table (ensure-dictionary name))
         (table (ensure-hash-table locale dict-table)))
    (loop for (word . mean) in dict
          do (setf (gethash word table) mean))))

@export
(defmethod register-dictionary (name (dict pathname) &key (locale *locale*))
  (register-dictionary name (read-from-string (slurp-file dict))
                       :locale locale))

(defun slurp-file (path)
  "Read a specified file and return the content as a sequence."
  (with-open-file (stream path :direction :input
                          :external-format :utf-8)
    (let ((seq (make-array (file-length stream) :element-type 'character :fill-pointer t)))
      (setf (fill-pointer seq) (read-sequence seq stream))
      seq)))

(defun %define-dictionary (name &rest msg-clauses)
  (loop for (locale dict) in msg-clauses
        do (register-dictionary name dict :locale locale)))

@export
(defmacro define-dictionary (name &body msg-clauses)
  `(progn
     (%define-dictionary ',name
       ,@(mapcar #'(lambda (clause) (cons 'list clause)) msg-clauses))
     (setf (current-dictionary) ',name)))

@export
(defun current-dictionary ()
  *dictionary*)

@export
(defun (setf current-dictionary) (name)
  (setf *dictionary* (ensure-dictionary name)))

@export
(defun i18n (string &key params (locale *locale*) (dictionary (current-dictionary)))
  (apply #'format nil
         (or (aand (not (eq locale *default-locale*))
                   (gethash locale dictionary)
                   (gethash string arnesi:it))
             string)
         params))

@export
(defun i18n-unformatted (string &key (locale *locale*) (dictionary (current-dictionary)))
  (aand (not (eq locale *default-locale*))
           (gethash locale dictionary)
           (gethash string arnesi:it)))
