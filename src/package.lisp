(in-package :cl-user)

(defpackage cl-locale
  (:use :cl)
  (:export :i18n
           :define-dictionary
           :*default-locale* :*locale* :*locales*
           :*dictionary-name* :*dictionaries*))
