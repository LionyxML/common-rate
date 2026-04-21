(asdf:defsystem #:common-rate
    :description "A fetcher for current rate of some asset like BTC vs USD"
    :author "RMJ"
    :license "MIT"
    :version "0.1.0"
    :depends-on (#:dexador #:jonathan)
    :entry-point "common-rate:main"
    :components
    ((:module "src"
      :components
      ((:file "packages")
       (:file "parse"  :depends-on ("packages"))
       (:file "fetch"  :depends-on ("packages"))
       (:file "cli"    :depends-on ("packages"))
       (:file "domain" :depends-on ("packages"))
       (:file "main"   :depends-on ("packages" "parse" "fetch" "domain" "cli"))))))
