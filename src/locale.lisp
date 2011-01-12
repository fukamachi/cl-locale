(in-package :cl-locale)

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

(defmethod define-dictionary (name (dict pathname))
  (with-open-file (stream dict)
    (define-dictionary name (read-from-string (slurp-stream stream)))))

(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it ,then ,else)))

(defmacro aand (&rest args)
  (cond ((null args) t)
        ((null (cdr args)) (car args))
        (t `(aif ,(car args) (aand ,@(cdr args))))))

(defun i18n (string &key (locale *locale*) (dictionary *dictionary-name*))
  (or (aand (not (eq locale *default-locale*))
            (gethash dictionary *dictionaries*)
            (gethash string it)
            (getf it locale))
      string))
