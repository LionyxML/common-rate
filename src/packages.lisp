(defpackage #:common-rate
  (:use #:cl)
  (:export #:main))

(defpackage #:common-rate.cli
  (:use #:cl)
  (:export
   #:parse-args
   #:print-app-help
   #:print-app-version))

(defpackage #:common-rate.domain
  (:use #:cl)
  (:export #:normalize-crypto))

(defpackage #:common-rate.fetch
  (:use #:cl)
  (:export #:fetch-url))

(defpackage #:common-rate.parse
  (:use #:cl)
  (:export #:parse-crypto-rate))
