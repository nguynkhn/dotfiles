;; basic options
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t
      delete-old-versions t
      version-control t
      kept-new-versions 4
      kept-old-versions 2
      make-backup-files t)

(setq-default require-final-newline t)
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'whitespace-cleanup)

(global-display-line-numbers-mode t)

(electric-pair-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq line-number-mode t
      column-number-mode t)

(setq fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq confirm-kill-emacs 'yes-or-no-p)

;; gui

(set-frame-font "SFMono Nerd Font Mono 10" nil t)

;; package

(setq-default custom-file
	      (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file nil t)

(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
	("elpa"   . "https://elpa.gnu.org/packages/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t)
  (require 'use-package))

(use-package gruber-darker-theme
  :config (load-theme 'gruber-darker t))

(use-package emmet-mode
  :hook ((html-mode css-mode js-jsx-mode) . emmet-mode))
(use-package rust-mode)

(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :config (setq lsp-auto-guess-root t)
  :hook (((rust-mode) . lsp)
	 (lsp-mode . lsp-enable-which-key-OAintegration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package which-key :config (which-key-mode))

(use-package company
  :config (setq company-idle-delay 0.2
		company-minimum-prefix-length 1))
