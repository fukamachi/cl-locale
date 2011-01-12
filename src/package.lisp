(in-package :cl-user)

(defpackage cl-locale
  (:use :cl)
  (:export :i18n
           :make-dictionary :load-dictionary
           :*default-locale* :*locale* :*locales*
           :*dictionary*))
