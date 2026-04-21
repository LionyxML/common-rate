(in-package #:common-rate.parse)

(defun parse-crypto-rate (json id vs)
  (let* ((coin (getf json (intern id :keyword)))
         (rate (getf coin (intern vs :keyword))))
    rate))
