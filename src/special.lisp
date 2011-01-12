(in-package :cl-locale)

(defvar *default-locale* :en-US)
(defvar *locale* nil)
(defvar *locales* nil)
(defvar *dictionary* (make-hash-table :test 'equal))
