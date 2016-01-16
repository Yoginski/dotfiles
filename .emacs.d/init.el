(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


					; Required packages
(setq package-list '(evil powerline powerline-evil haskell-mode base16-theme company company-ghci flycheck flycheck-haskell))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


					; Hide menus
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 0)


					; Evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)


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


					; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)


					; Completions
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


					; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(require 'hi2)
;(add-hook 'haskell-mode-hook 'turn-on-hi2)
(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "C-c C-h") 'haskell-hoogle)
				  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
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
;;; To get completions in the REPL
(add-hook 'haskell-interactive-mode-hook 'company-mode)
