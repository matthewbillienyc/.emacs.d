;;; package --- Summary

;;; Commentary:

;; make melpa packages available

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aeb4dbed3dd5c639adcc574eb2e5698b08545dd3d1794ed7e9b4f2b8eb289e4" default)))
 '(package-selected-packages
   (quote
    (graphene-meta-theme badwolf-theme calmer-forest-theme dracula-theme dark-mint-theme jade js2-mode auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; do not make backup files
(setq make-backup-files nil)

;; install el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/el-get/helm")
(add-to-list 'load-path "~/.emacs.d/el-get/web-mode")
(add-to-list 'load-path "~/.emacs.d/el-get/projectile")
(add-to-list 'load-path "~/.emacs.d/el-get/smartparens")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(require 'js2-mode)

;;; enable helm mode
(require 'web-mode)

(require 'helm-mode)
(helm-mode 1)

;;; enable projectile
(require 'projectile)
(projectile-mode 1)

;; enable linum mode
(require 'linum)
(define-globalized-minor-mode global-linum
  linum-mode
  (lambda ()
    (linum-mode t))
  )
(global-linum t)

;; auto enable modes per file 
(add-to-list 'auto-mode-alist '("\\.js$\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; enable flycheck
(require 'flycheck)

;; rebind C-x C-b to buffer-menu
(global-set-key "\C-x\C-b" 'ibuffer)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(json-jsonlist)))

;; (defvar autopair-modes '(r-mode ruby-mode js2-mode))
;; (defun turn-on-autopair-mode () (autopair-mode 1))
;; (dolist (mode autopair-modes) (add-hook (intern (concat (symbol-name mode) "-hook")) 'turn-on-autopair-mode))

;; (require 'autopair)
;; (require 'paredit)
;; (defadvice paredit-mode (around disable-autopairs-around (arg))
;;   "Disable autopairs mode if paredit-mode is turned on"
;;   ad-do-it
;;   (if (null ad-return-value)
;;       (autopair-mode 1)
;;     (autopair-mode 0)
;;     ))

;; (ad-activate 'paredit-mode)

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; enable smartparens globally
(require 'smartparens)
(define-globalized-minor-mode global-smartparens
  smartparens-mode
  (lambda ()
    (smartparens-mode t))
  )
(global-smartparens t)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; auto enable globalized auto-complete-mode
(require 'auto-complete)
(define-globalized-minor-mode global-complete
  auto-complete-mode
  (lambda ()
    (auto-complete-mode t))
  )
(global-complete t)

;; (require 'dracula-theme)
;; (load-theme 'dracula-theme t)

;;; (require 'calmer-forest-theme)
;;; (load-theme 'calmer-forest-theme t)

(require 'badwolf-theme)
(load-theme 'badwolf-theme t)
