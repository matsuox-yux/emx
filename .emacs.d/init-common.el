;; -*- coding: utf-8; mode: emacs-lisp -*-

;バッファが文字化けした場合
;universal-coding-system-argument
;C-x RET c utf-8 RET C-x C-v RET
;こっちのほうがいい
;(revert-buffer-with-coding-system)
;C-x RET r utf-8 RET

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(prefer-coding-system 'utf-8-unix)

(setq delete-selection-mode nil)

(require 'server)
(unless (eq (server-running-p) 't)
  (server-start))

; NFD分離表示
(global-auto-composition-mode -1)

(setq load-path
      (nconc
       (list
        (expand-file-name "~/.emacs.d/jisaku")
        (expand-file-name "~/.emacs.d/elisp")
        )
       load-path))

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(column-number-mode t)
(line-number-mode t)
;(setq default-major-mode 'fundamental-mode)
;(setq initial-major-mode 'fundamental-mode)
(setq default-major-mode 'text-mode)
(setq initial-major-mode 'text-mode)

(if (string= system-type "darwin") ;;  not GNU ls
    (progn
      (setq dired-use-ls-dired nil))
  (progn
    (setq dired-use-ls-dired t)
    (setq dired-listing-switches "-alF")))

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq next-line-add-newlines nil)
(transient-mark-mode nil) ;; 選択範囲に色をつけない
(blink-cursor-mode 0)    ;; カーソルの点滅をやめる
(setq default-tab-width 4) ;tab 4
(global-font-lock-mode t) ;for standing out the environment keywords
(show-paren-mode 1) ;for remark of the other paren
(setq ring-bell-function 'ignore) ;フラッシュもビープ音も消す
(setq read-file-name-completion-ignore-case nil)
(setq line-move-visual nil) ;論理行移動!!
(setq auto-save-list-file-name nil) ; not make .save..files
(setq auto-save-list-file-prefix nil)
(setq undo-outer-limit 200000000)
(setq large-file-warning-threshold nil)
(setq font-lock-maximum-decoration
      '((tex-mode . 1) (latex-mode . 1) (t . t))) ;LaTeXモードの過剰装飾を禁止

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


(fset 'yes-or-no-p 'y-or-n-p)
(setq search-whitespace-regexp nil)

; ;; 選択領域を削除キーで一括削除 kill-ringに入らない
(delete-selection-mode t)

; 行頭でC-kしたときには改行文字も削除する
;(setq kill-whole-line t)

;;以前のように改行はただの改行でインデントしない
(electric-indent-mode 0)
;;タブを使わない
(setq-default indent-tabs-mode nil)

;;自作ライブラリ
(load "jisaku")

;;ファイル名が同名だった場合にその一階層上のディレクトリ名が出るようにする。
(autoload 'uniquify-run "uniquify" nil t)
(with-eval-after-load 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))


;; 共通キーバインド
;(define-key global-map "\C-cd" 'jdate)
(define-key global-map "\C-cd" 'insert-time-and-log)
(define-key global-map "\C-co" 'insert-tab1tabname)

; (define-key global-map "\C-c(" 'marukakko-line)
(define-key global-map "\C-c#" 'left-region)
(define-key global-map "\C-c\\" 'right-region)
(define-key global-map "\C-cn" 'write-numbers)
;(define-key global-map "\C-cl" 'line-to-top-of-window)
(define-key global-map "\C-l" 'line-to-top-of-window)
(define-key global-map "\C-ck" 'killblank)
(define-key global-map "\C-cj" 'killtopblank)
(define-key global-map "\C-c-" 'kill-kaigyo-region)
(define-key global-map "\C-cq" 'query-replace-regexp)
(define-key global-map "\C-cs" 'replace-string)
(define-key global-map "\C-cw" 'replace-regexp)
(define-key global-map "\C-cc" 'set-buffer-file-coding-system)
(define-key global-map "\C-ce" 'e-html)
(define-key global-map "\C-cf" 'xah-replace-invisible-char)
(define-key global-map "\C-cg" 'ucs-normalize-NFC-region)
(define-key global-map "\C-cb" 'ucs-normalize-NFD-region)
(define-key global-map "\C-ct" 'toggle-truncate-lines)
(define-key global-map "\C-cu" 'uniq-lines)
(define-key global-map "\C-xn" 'other-window)
(define-key global-map "\C-xp" 'other-window-backward)
(define-key global-map "\C-ci" 'insert-regex)
;(define-key global-map "\C-c5" 'md5format)
;(define-key global-map "\C-_" 'undo)
(define-key global-map "\M-h" 'help-command)
(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map "\M-g" 'goto-line)
(define-key global-map "\C-cr" 'revert-buffer)
(define-key global-map "\C-ch" 'backward-kill-line)

;(define-key global-map (kbd "\C-ch") (kbd "C-u 0 C-k"))
(define-key global-map (kbd "C-,") (kbd "C-u 0 C-k"))

;(define-key global-map "\C-c@" 'insert-mv)

; 日本語入力を使わない
(global-unset-key (kbd "C-\\"))
(setq default-input-method nil)

; ミニバッファ = 常に英語
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (deactivate-input-method)))
;; 行番号表示
(global-set-key "\M-n" 'global-display-line-numbers-mode)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; タブ文字や全角スペースを目立たせる ここから ;;;;;;;;;;;;;;
(progn
  (require 'whitespace)
  ;; 空白
  (set-face-foreground 'whitespace-space nil)
  (set-face-background 'whitespace-space "red")
  ;; ファイル先頭と末尾の空行
  ;(set-face-background 'whitespace-empty "gray33")
  ;; タブ
  (set-face-foreground 'whitespace-tab nil)
  (set-face-background 'whitespace-tab "gray33")
  ;; ???
  (set-face-background 'whitespace-trailing "gray33")
  (set-face-background 'whitespace-hspace "gray33")

  (setq whitespace-style
        '(face         ; faceで可視化
          trailing     ; 行末
          tabs         ; タブ
;          empty        ; 先頭/末尾の空行
          spaces       ; 空白
          space-mark   ; 表示のマッピング
          tab-mark))
  ;; スペースは全角のみを可視化
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  ;; タブの表示を変更
  (setq whitespace-display-mappings
        '((tab-mark ?\t [?\xBB ?\t])))
  ;; 発動
  (global-whitespace-mode t))
;;; タブ文字や全角スペースを目立たせる ここまで ;;;;;;;;;;;;;;

;;;;;; モードラインの文字コード情報変更 ここから ;;;;;;;;;;;;;;
(progn
  (require 'cl-lib)
  ;; 改行文字の文字列表現
  (set 'eol-mnemonic-dos "(CRLF)")
  (set 'eol-mnemonic-unix "(LF)")
  (set 'eol-mnemonic-mac "(CR)")
  (set 'eol-mnemonic-undecided "(?)")

  ;; 文字エンコーディングの文字列表現
  (defun my-coding-system-name-mnemonic (coding-system)
    (let* ((base (coding-system-base coding-system))
           (name (symbol-name base)))
      (cond ((string-prefix-p "utf-8" name) "U")
            ((string-prefix-p "utf-16" name) "U16")
            ((string-prefix-p "utf-7" name) "U7")
            ((string-prefix-p "japanese-shift-jis" name) "SJIS")
            ((string-match "cp\\([0-9]+\\)" name) (match-string 1 name))
            ((string-match "japanese-iso-8bit" name) "EUC")
            (t "???")
            )))
  (defun my-coding-system-bom-mnemonic (coding-system)
    (let ((name (symbol-name coding-system)))
      (cond ((string-match "be-with-signature" name) "[BE]")
            ((string-match "le-with-signature" name) "[LE]")
            ((string-match "-with-signature" name) "[BOM]")
            (t ""))))
  (defun my-buffer-coding-system-mnemonic ()
    "Return a mnemonic for `buffer-file-coding-system'."
    (let* ((code buffer-file-coding-system)
           (name (my-coding-system-name-mnemonic code))
           (bom (my-coding-system-bom-mnemonic code)))
      (format "%s%s" name bom)))
  ;; `mode-line-mule-info' の文字エンコーディングの文字列表現を差し替える
  (setq-default mode-line-mule-info
                (cl-substitute '(:eval (my-buffer-coding-system-mnemonic))
                               "%z" mode-line-mule-info :test 'equal)))
;;;;;; モードラインの文字コード情報変更 ここまで ;;;;;;;;;;;;;;


;; タイトルにフルパス表示
(setq frame-title-format "%f")

;;current directory 表示
(let ((ls (member 'mode-line-buffer-identification
                  mode-line-format)))
  (setcdr ls
          (cons '(:eval (concat
                         " ("
                         (abbreviate-file-name default-directory)
                         ")"))
                (cdr ls))))

; ;; 非アクティブウィンドウの背景色を設定
; (require 'hiwin)
; (hiwin-activate)
; (set-face-background 'hiwin-face "gray30")

(setq auto-mode-alist
      (append
       '(("\\.java$" . java-mode)
         ("\\.php$" . php-mode)
;         ("\\.cu$" . c-mode)
;         ("\\.tpl$" . xml-mode)
;         ("\\.jsp$" . xml-mode)
;         ("\\.html$" . xml-mode)
;         ("\\.tpl$" . web-mode)
;         ("\\.jsp$" . web-mode)
;         ("\\.html$" . web-mode)
;         ("\\.svg$" . web-mode)
         )
       auto-mode-alist))

;; c-mode
;(load "my-c")
(add-hook 'c-mode-hook
          #'(lambda ()
             (turn-on-font-lock)
;             (c-set-style "bsd")))
             (setq indent-tabs-mode nil)
             (setq c-auto-newline nil)
             (c-set-style "stroustrup")))

;; HTMLの保存で勝手にコーディングシステムを変えられないようにする
(delete 'sgml-html-meta-auto-coding-function auto-coding-functions)

;;; ===== nXML =====
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 4)
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (define-key nxml-mode-map "\r" 'newline-and-indent)))


;; For Aspell
(progn
  (setq-default ispell-program-name "aspell")
  (eval-after-load "ispell"
    '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))))
