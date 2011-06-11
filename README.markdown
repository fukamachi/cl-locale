# CL-Locale - Simple i18n library for Common Lisp

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

## Dictionary Resource

    ; ja_JP/message.lisp
    (("Schedule" . "予定")
     ("Lisping" . "舌足らず"))
    
    ; fr_FR/message.lisp
    (("Schedule" . "Calendrier"))

## License

Copyright (c) 2011 Eitarow Fukamachi  
Licensed under the LLGPL License.
