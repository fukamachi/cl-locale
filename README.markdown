# CL-LOCALE - Simple i18n library for Common Lisp

## Usage

    (define-dictionary "sche" #p"i18n/messages.lisp")
    (i18n "Schedule")
    ;;=> "Schedule"
    (i18n "Schedule" :locale :ja-JP)
    ;;=> "予定"
    (let ((*locale* :fr-FR))
      (i18n "Calendrier"))
    ;;=> "予定"

## Dictionary Resource

    (("Schedule" :ja-JP "予定" :fr-FR "Calendrier")
     ("Lisping" :ja-JP "舌足らず"))

## License

Copyright (c) 2011 Eitarow Fukamachi  
Licensed under the LLGPL License.
