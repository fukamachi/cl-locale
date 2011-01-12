(in-package :cl-locale)

(defvar *default-locale* :en-US)
(defvar *locale* nil)
(defvar *locales* nil)
(defvar *dictionary-name* nil)
(defvar *dictionaries* (make-hash-table :test 'equal))
