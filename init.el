(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq use-package-always-ensure t)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
(setq doom-theme 'doom-gruvbox)

(set-face-attribute 'default nil
                    :font "Mononoki Nerd Font"
                    :height 150
                    :weight 'medium)
(set-face-attribute 'variable-pitch nil
                    :font "Mononoki Nerd Font"
                    :height 180
                    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "Hack Nerd Font"
                    :height 150
                    :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font-15"))
;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(use-package beacon
  :ensure t
  :config
    (beacon-mode 1))

(use-package counsel
  :after ivy
  :config (counsel-mode))
(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))
(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))
(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))  ;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :after ivy
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package company )
(add-hook 'after-init-hook 'global-company-mode)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq dashboard-banner-logo-title "EMACS")
(setq dashboard-startup-banner "~/.config/emacs/avatar.png")
(setq dashboard-center-content t)
(setq dashboard-display-icons-p nil) ;; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(dolist (mode '(dashboard-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))) ;; Don't show line numbers, Obviosly

(use-package evil
  :init      ;; tweak evil's configuration before loading it
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))
(use-package evil-tutor)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :hook (after-init . doom-modeline-mode))
(setq doom-modeline-height 30)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package vterm)
(setq vterm-toggle-fullscreen-p nil)
(add-to-list 'display-buffer-alist
             '((lambda (buffer-or-name _)
                 (let ((buffer (get-buffer buffer-or-name)))
                   (with-current-buffer buffer
                     (or (equal major-mode 'vterm-mode)
                         (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
               (display-buffer-reuse-window display-buffer-at-bottom)
               (reusable-frames . visible)
               (window-height . 0.3)))
;; Disable line numbers for some modes
(dolist (mode '(vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package which-key
  :init
  (which-key-mode 1))
  ;;:config
   ;;(setq which-key-sort-uppercase-first nil
         ;;which-key-idle-delay 0.8
         ;;which-key-separator " → " ))

;  (setq ring-bell-function 'ignore)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(global-hl-line-mode t)

(setq use-dialog-box nil)  ;; Don't use gui dialog boxes.

(setq inhibit-startup-message t)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(electric-pair-mode 1)     ;; Enable automatic insertion of matching brackets

(defalias 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)
(setq auto-save-default nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;;

(column-number-mode)       ;; Show Column numbers too.

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package all-the-icons
  :ensure t
  :init)
(use-package all-the-icons-dired
  :ensure t
  :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
(use-package all-the-icons-ibuffer
  :ensure t
  :init (all-the-icons-ibuffer-mode 1))

(use-package org-auto-tangle
  :ensure t
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(global-subword-mode 1)

(use-package general
  :config
  (general-evil-setup)
  ;; set up 'SPC' as the global leader key
  (general-create-definer emacs/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode
  (emacs/leader-keys
    "f" '(:ignore t :wk "File Options")
    "." '(find-file :wk "Find file")
    "f f" '(find-file :wk "Find file")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/README.org")) :wk "Edit emacs config")
    "TAB TAB" '(comment-line :wk "Comment lines"))
  (emacs/leader-keys
    "o" '(:ignore t :wk "Org-Mode Commands")
    "o a" '(org-agenda :wk "Org Agenda")
    "o o" '(org-mode :wk "Org Mode"))
  (emacs/leader-keys
    ";" '(:ignore t :wk "Bookmark Options")
    "; b" '(bookmark-jump :wk "Quickly Jump to a Bookmark")
    "; a" '(bookmark-set :wk "Create a Bookmark")
    "; d" '(bookmark-delete :wk "Delete a Saved Bookmark"))
  (emacs/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b b" '(ibuffer-jump-to-buffer :wk "Switch buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))
  (emacs/leader-keys
    "q" '(:ignore t :wk "Quit Something")
    "q b" '(kill-this-buffer :wk "Quit current Buffer") 
    "q w" '(quit-window :wk "Quit Window and bury its Buffer"))
  (emacs/leader-keys
    "e" '(:ignore t :wk "Evaluate")    
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")) 
  (emacs/leader-keys
    "s" '(:ignore t :wk "Swiper Search")
    "s s" '(swiper :wk "Search current Buffer") 
    "s a" '(swiper-all :wk "Search all Active Buffers"))
  (emacs/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
  (emacs/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(vterm-toggle :wk "Toggle Terminal")
    "t v" '(visual-line-mode :wk "Toggle to View truncated lines"))
  )

(use-package sudo-edit
  :ensure t
  :bind ("s-e" . sudo-edit))

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-tempo)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  :hook (prog-mode . lsp-mode)
  )
(use-package lsp-ui
  :commands lsp-ui-mode)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-ui-sideline-show-code-actions t)
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))
