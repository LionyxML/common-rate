(in-package #:common-rate)

(defun main ()
  (let ((args (uiop:command-line-arguments)))
    (multiple-value-bind (status a b)
        (common-rate.cli:parse-args args)

      (case status
        (:version
         (common-rate.cli:print-app-version)
         (sb-ext:exit :code 0))

        (:help
         (common-rate.cli:print-app-help)
         (sb-ext:exit :code 0))

        (:error
         (format *error-output* "~%Error: ~A~2%" a)
         (common-rate.cli:print-app-help)
         (sb-ext:exit :code 1))

        (:ok
         (handler-case
             (let* ((from a)
                    (to   b)
                    (id   (common-rate.domain:normalize-crypto from))
                    (vs   (common-rate.domain:normalize-crypto to))
                    (url  (format nil
                                  "https://api.coingecko.com/api/v3/simple/price?ids=~A&vs_currencies=~A"
                                  id vs))
                    (raw  (common-rate.fetch:fetch-url url))
                    (json (jonathan:parse raw))
                    (rate (common-rate.parse:parse-crypto-rate json id vs)))

               (format t "~A -> ~A: ~A~%" from to rate)
               (finish-output)
               (sb-ext:exit :code 0))

           (error (e)
             (format *error-output* "~%Runtime error: ~A~%" e)
             (finish-output *error-output*)
             (sb-ext:exit :code 1))))))))
