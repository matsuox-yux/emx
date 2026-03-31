;; -*- coding: utf-8; mode: emacs-lisp -*-

(when (eq window-system 'x)
  (set-face-attribute 'default nil :family "SOROEMONO" :height 110)
  (load-theme 'tango-dark t)
  (setq default-frame-alist
        (append (list
                 '(width . 80)
                 '(height . 100)
                 '(top . 0)
                 ; '(left . 650)
                 )))
  (keymap-global-set "M-<XF86Tools>" 'just-one-space)
  )



(progn
  (require 'mozc)
  (setq default-input-method "japanese-mozc")
  ; 変換候補が変換対象のすぐ下に表示される。
  (setq mozc-candidate-style 'overlay)
  ; 変換候補がミニバッファに表示される。こちらのほうが無難
  ;(setq mozc-candidate-style 'echo-area))

  ;; mozc 変換/無変換キーでOn/Off
  (global-set-key (kbd "M-[") #'(lambda ()
                                  (interactive)
                                  (mozc-mode 0)
                                        ;(mozc-mode-line-indicator-update)
                                  ))
  (global-set-key (kbd "M-]") #'(lambda ()
                                  (interactive)
                                  (mozc-mode 1)
                                        ;(mozc-mode-line-indicator-update)
                                  ))
  (require 'cl-lib)
  (defun advice:mozc-key-event-with-ctrl-key--with-ctrl (r)
    (cond ((and (not (null (cdr r))) (eq (cadr r) 'control) (null (cddr r)))
           (cl-case (car r)
             (102 r) ; C-f
             (98 r)  ; C-b
             (110 '(down)) ; C-n
             (112 '(up))   ; C-p
             (t r)))
          (t r)))
  (advice-add 'mozc-key-event-to-key-and-modifiers :filter-return 'advice:mozc-key-event-with-ctrl-key--with-ctrl)
  (advice-remove 'mozc-key-event-to-key-and-modifiers 'mozc-key-event-with-ctrl-key)
  )
