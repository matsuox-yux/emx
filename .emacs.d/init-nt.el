;; -*- coding: utf-8; mode: emacs-lisp -*-

(prefer-coding-system 'utf-8-unix)

(set-face-attribute 'default nil :family "SOROEMONO" :height 110)
(load-theme 'tango-dark t)

(setq default-frame-alist
      (append
       (list
        '(width . 40)
        '(height . 120)
        '(top . 0)
;        '(left . 0)
        )))

(setq default-directory (getenv "HOME"))
