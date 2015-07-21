# CL-Locale - Simple i18n library for Common Lisp
[![Build Status](https://travis-ci.org/fukamachi/cl-locale.svg?branch=master)](https://travis-ci.org/fukamachi/cl-locale)
[![Coverage Status](https://coveralls.io/repos/fukamachi/cl-locale/badge.svg?branch=master)](https://coveralls.io/r/fukamachi/cl-locale?branch=master)


## Usage

    (cl-locale:enable-locale-syntax)
    
    (define-dictionary schedule
      (:ja-JP #p"i18n/ja_JP/message.lisp")
      (:fr-FR #p"i18n/fr_FR/message.lisp"))
    
    (define-dictionary lisp
      (:ja-JP #p"i18n/ja_JP/message.lisp"))
    
    (setf (current-dictionary) :schedule)
    
    #i"Schedule"
    ;=> "Schedule"
    
    (i18n "Schedule" :locale :ja-JP)
    ;=> "予定"
    
    (let ((*locale* :fr-FR))
      #i"Schedule")
    ;=> "Calendrier"
    
    #i("Comments: ~A" 10)
    ;=> "コメント: 10個"

## What the difference

* cl-i18n: Does nit support loading multiple locales at the same time.
* cl-l10n: No reader macro predefined. No tools to automatically generate localizable files / language files.

## Dictionary Resource

    ; ja_JP/message.lisp
    (("Schedule" . "予定")
     ("Lisping" . "舌足らず"))
    
    ; fr_FR/message.lisp
    (("Schedule" . "Calendrier"))

## License

Copyright (c) 2011 Eitarow Fukamachi  
Licensed under the LLGPL License.
