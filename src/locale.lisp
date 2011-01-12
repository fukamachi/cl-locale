(in-package :cl-locale)

(defun make-dictionary (dict-list)
  (loop for (word . plist) in dict-list
        do (setf (gethash word *dictionary*) plist)
           (loop for locale in plist by #'cddr do (pushnew locale *locales*))))

(defun slurp-stream (stream)
  (let ((seq (make-string (file-length stream))))
    (read-sequence seq stream)
    seq))

(defun load-dictionary (dict-file)
  (with-open-file (stream dict-file)
    (make-dictionary (read-from-string (slurp-stream stream)))))

(defun i18n (string &key (locale *locale*))
  (if (eq locale *default-locale*)
      string
      (let ((plist (gethash string *dictionary*)))
        (if plist
            (or (getf plist locale) string)
            string))))
