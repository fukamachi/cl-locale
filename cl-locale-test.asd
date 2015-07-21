#|
  This file is a part of CL-Locale package.
  URL: http://github.com/arielnetworks/cl-locale
  Copyright (c) 2011 Eitarow Fukamachi <e.arrows@gmail.com>

  CL-Locale is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage cl-locale-test-asd
  (:use :cl :asdf))
(in-package :cl-locale-test-asd)

(defsystem cl-locale-test
  :depends-on (:cl-locale
               :flexi-streams
               :prove)
  :components ((:module "t"
                :components
                ((:file "locale"))))
  :description "Test system for cl-locale."
  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
