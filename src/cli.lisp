(in-package #:common-rate.cli)

(defparameter *app-version* "0.1.0")
(defparameter *app-bin-name* "common-rate")
(defparameter *app-name* "Common-Rate")
(defparameter *app-description*
  "This app fetches current rate between two currencies")

(defun print-app-version ()
  (format t "~2%~A~2%" *app-version*))

(defun print-app-help ()
  (format t "~2%~A ~20T[version: ~A]~2%" *app-name* *app-version*)
  (format t "~A~2%" *app-description*)

  (format t "Usage: ~20T~A [options]~% ~20T~A <FROM> <TO>~2%"
          *app-bin-name* *app-bin-name*)

  (format t "Example: ~20T~A BTC BRL~2%" *app-bin-name*)

  (format t "Options:~%")
  (format t "  -h, --help~20TShow help~%")
  (format t "  -v, --version~20TShow version~%~%"))

(defun parse-args (args)
  (cond
    ((or (member "--version" args :test #'string=)
         (member "-v"        args :test #'string=))
     (values :version nil nil))

    ((or (member "--help" args :test #'string=)
         (member "-h"     args :test #'string=))
     (values :help nil nil))

    ((= (length args) 2)
     (values :ok (first args) (second args)))

    (t
     (values :error "Invalid arguments" nil))))
