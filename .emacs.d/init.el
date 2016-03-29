(modify-frame-parameters nil '((wait-for-wm . nil)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

					; Hide menus
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 0)
(setq inhibit-startup-message t)

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


					; Required packages
(setq package-list '(highlight-parentheses evil powerline powerline-evil haskell-mode base16-theme company company-ghci flycheck hi2 flycheck-haskell evil-paredit slime slime-company helm racket-mode company-jedi))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


					; Evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)


					; Tabs
(setq c-basic-offset 4)
(setq tab-width 4)
(setq indent-tabs-mode nil)


					; Colors
(setq sml/no-confirm-load-theme t)
(load-theme 'base16-default-dark t)


					; Status line
(require 'powerline)
(powerline-center-evil-theme)


					; Line numbers
(global-linum-mode t)


					; Shell
(global-set-key [f1] 'ansi-term)
(global-set-key [f2] 'async-shell-command)


					; Fonts
(set-face-attribute 'default nil :font "Liberation Mono-12" )
(set-frame-font "Liberation Mono-12" nil t)


					; Helm
(require 'helm)
(helm-mode 1)
(global-set-key (kbd "C-x C-p") 'helm-find)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-for-files)
(add-to-list 'helm-boring-buffer-regexp-list "\*[Hh]elm.+\*")
(add-to-list 'helm-boring-buffer-regexp-list "\*Flycheck.+\*")
(add-to-list 'helm-boring-buffer-regexp-list "*Messages*")
(add-to-list 'helm-boring-buffer-regexp-list "*GNU Emacs*")
(define-key helm-map (kbd "[f1]") 'ansi-term)


(define-key minibuffer-local-map [f3]
  (lambda () (interactive) 
     (insert (buffer-name (window-buffer (minibuffer-selected-window))))))

					; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)


					; Completions
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key company-active-map (kbd "\C-n") 'company-select-next)
(define-key company-active-map (kbd "\C-p") 'company-select-previous)
(define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
(define-key company-active-map (kbd "<tab>") 'company-complete)


					; Haskell
					;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(require 'hi2)
(add-hook 'haskell-mode-hook 'turn-on-hi2)
(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "C-c C-h") 'haskell-hoogle)
				  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
				  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
				  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
				  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
				  (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
				  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
				  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
				  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
				   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
				   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
				   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
				   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))


					; Haskell completions
(require 'company-ghci)
(push 'company-ghci company-backends)
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-interactive-mode-hook 'company-mode)


					; Python
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

					; Common Lisp
(setq slime-contribs '(slime-fancy))
(require 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl")
(slime-setup '(slime-company))

(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
;; (add-hook 'lisp-mode-hook 'evil-paredit-mode)
;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
;; (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
