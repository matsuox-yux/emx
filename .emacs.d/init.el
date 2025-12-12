;一旦停止
(defconst my-saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; leaf
(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (use-package leaf :ensure t)

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init))

  (leaf leaf-convert
    :ensure t))

(leaf migemo
  :if (executable-find "cmigemo")
  :ensure t
  :custom
  '((migemo-user-dictionary  . nil)
    (migemo-regex-dictionary . nil)
    (migemo-options          . '("-q" "--emacs"))
    (migemo-command          . "cmigemo")
    (migemo-coding-system    . 'utf-8-unix))
  :init
  (cond
   ((eq system-type 'darwin)
    (setq migemo-dictionary
          "/opt/homebrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict"))
   ((eq system-type 'gnu/linux)
    (setq migemo-dictionary
          "/usr/share/cmigemo/utf-8/migemo-dict"))
   ((eq system-type 'windows-nt)
    (setq migemo-dictionary
          (concat (file-name-directory (executable-find "cmigemo")) "dict/utf-8/migemo-dict"))))
  :hook
  (after-init-hook . migemo-init))

(leaf undo-tree
  ; キーバインド
  ; C-x uで開始
  :ensure t
  :global-minor-mode global-undo-tree-mode
  :custom
  (undo-tree-auto-save-history . nil))

(leaf markdown-mode
  :ensure t
  :mode
  (("\\.md\\" . gfm-mode)))

(leaf org
  :ensure t
  :mode
  ("\\.org$" . org-mode)
  :custom
  (org-src-fontify-natively . t)
  (org-startup-truncated . t))

(leaf treesit
  ;; treesit-install-language-grammarを実行
  :mode
  (("\\.py$" . python-ts-mode)
   ("\\.c$" . c-ts-mode)
   ("\\.h$" . c-ts-mode)
   ("\\.cpp$" . cpp-ts-mode)
   ("\\.rs$" . rust-ts-mode)
   ("\\.html$" . html-ts-mode)
   ("\\.htm$" . html-ts-mode)
   ("\\.yaml$" . yaml-ts-mode)
   ("\\.yml$" . yaml-ts-mode))
  :config
  ; カラーレベルをMAXにする
  (setopt treesit-font-lock-level 4)
  (setopt treesit-language-source-alist
          '(
            (bash "https://github.com/tree-sitter/tree-sitter-bash")
            (css "https://github.com/tree-sitter/tree-sitter-css")
            (elisp "https://github.com/Wilfred/tree-sitter-elisp")
            ;(go "https://github.com/tree-sitter/tree-sitter-go")
            (html "https://github.com/tree-sitter/tree-sitter-html")
            (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
            (json "https://github.com/tree-sitter/tree-sitter-json")
            (markdown "https://github.com/ikatyang/tree-sitter-markdown")
            ;(toml "https://github.com/tree-sitter/tree-sitter-toml")
            ;(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
            ;(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
            (yaml "https://github.com/ikatyang/tree-sitter-yaml")
            (python "https://github.com/tree-sitter/tree-sitter-python")
            (c "https://github.com/tree-sitter/tree-sitter-c")
            (h "https://github.com/tree-sitter/tree-sitter-c")
            (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
            (rust "https://github.com/tree-sitter/tree-sitter-rust")
            )))

(leaf puni
  :ensure t
  :global-minor-mode puni-global-mode
  :config
  (define-key puni-mode-map (kbd "DEL") nil)
  (define-key puni-mode-map (kbd "C-d") nil)
  (define-key puni-mode-map (kbd "M-d") nil)
  (define-key puni-mode-map (kbd "M-DEL") nil)
  (define-key puni-mode-map (kbd "C-k") nil)
  (define-key puni-mode-map (kbd "C-S-k") nil)
  (define-key puni-mode-map (kbd "C-c DEL") nil)
  (define-key puni-mode-map (kbd "C-w") nil)
  ;(define-key puni-mode-map (kbd "C-M-f") nil)
  ;(define-key puni-mode-map (kbd "C-M-b") nil)
  ;(define-key puni-mode-map (kbd "C-M-a") nil)
  ;(define-key puni-mode-map (kbd "C-M-e") nil)
  (define-key puni-mode-map (kbd "M-(") nil)
  (define-key puni-mode-map (kbd "M-)") nil)
  (define-key puni-mode-map (kbd "C-M-o") 'puni-mark-sexp-at-point)
  (define-key puni-mode-map (kbd "C-M-p") 'puni-mark-list-around-point)
  (define-key puni-mode-map (kbd "C-M-i") 'puni-mark-sexp-around-point)
  (define-key puni-mode-map (kbd "C-M-u") 'puni-expand-region))

(leaf paren
  :doc "highlight matching paren"
  :global-minor-mode show-paren-mode
  :config
  ;(setq show-paren-style 'mixed)
  (setq show-paren-style 'expression)
  )

(leaf corfu
  :doc "COmpletion in Region FUnction"
  :ensure t
  :global-minor-mode global-corfu-mode corfu-popupinfo-mode
  :custom ((corfu-auto . t)
           (corfu-auto-delay . 0)
           (corfu-auto-prefix . 1)
           (corfu-popupinfo-delay . nil)) ; manual
  :bind ((corfu-map
          ("C-s" . corfu-insert-separator))))

(leaf cape
  :doc "Completion At Point Extensions"
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(leaf eglot
  :hook
  ;(html-mode . eglot-ensure)
  ;(go-mode . eglot-ensure)
  ;(typescript-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure)
  )

;; common
(load (expand-file-name "~/.emacs.d/init-common.el"))

(cond
;; MacOSX
((eq system-type 'darwin)
 (progn
       (load (expand-file-name "~/.emacs.d/init-mac.el"))
       ))
;; Linux
((eq system-type 'gnu/linux)
 (progn
       (load (expand-file-name "~/.emacs.d/init-linux.el"))
       ))
;; *BSD
((eq system-type 'berkeley-unix)())
;; Windows
((eq system-type 'windows-nt)
 (progn
       (load (expand-file-name "~/.emacs.d/init-nt.el"))
       ))
;; solaris 11
((eq system-type 'usg-unix-v)())
)

(setq gc-cons-threshold 33554432) ; 32MB
(setq file-name-handler-alist my-saved-file-name-handler-alist)

