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
  :diminish
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))
(use-package ivy-rich
  :after counsel
  :init (setq ivy-rich-path-style 'abbrev
              ivy-virtual-abbreviate 'full)
  :config (ivy-rich-mode))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

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

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

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
;; Don't Show Evil Mode State in Modeline
(with-eval-after-load 'evil
  (setq evil-normal-state-tag   nil
        evil-emacs-state-tag    nil
        evil-insert-state-tag   nil
        evil-motion-state-tag   nil
        evil-visual-state-tag   nil
        evil-operator-state-tag nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

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
(use-package vterm-toggle)

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order
        which-key-allow-imprecise-window-fit nil
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → " ))

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

;;(set-frame-parameter nil 'alpha-background 90)
;;(add-to-list 'default-frame-alist '(alpha-background . 90))
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;;  (set-frame-parameter (selected-frame) 'alpha '(90 . 80))
(add-to-list 'default-frame-alist '(alpha . (90 . 80)))

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

(defun compile-c-cpp-program ()
  (interactive)
  (let* ((file-name (buffer-file-name))
         (program-name (file-name-sans-extension file-name))
         (compile-cmd (format "gcc -Wall -Wextra -o %s %s -lm" program-name file-name)))
    ;; Compile the C program
    (compile compile-cmd))
  ;; Switch to the *compilation* buffer
  (pop-to-buffer "*compilation*"))

(defun run-c-cpp-program ()
  (interactive)
  (let* ((file-name (buffer-file-name))
         (program-name (file-name-sans-extension file-name))
         (executable program-name))

    (if (file-exists-p executable)
        (progn
          ;; Run the executable in a comint-run buffer
          (async-shell-command executable (format "*%s*" program-name))
          (pop-to-buffer (format "*%s*" program-name)))
      (message "Executable not found. Please compile the program first. Also, Make sure executable has same name as C source code without extension and in same directory as well."))))

(defun run-python-program ()
  (interactive)
  (let* ((file-name (buffer-file-name))
         (executable "python")
         (args (list executable file-name)))

    ;; Run the Python program in a comint-run buffer
    (if (file-exists-p executable)
        (progn
          (pop-to-buffer (format "Python: %s" (buffer-name)))
          (comint-mode)
          (erase-buffer)
          (apply 'make-comint-in-buffer "Python" nil executable nil args)))
    (message "Python executable not found. Please make sure Python is installed.")))

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

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
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "f f" '(find-file :wk "Find file")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/README.org")) :wk "Edit emacs config")
    "f t" '((lambda () (interactive) (find-file "~/dox/orgs/org-agenda/tasks.org")) :wk "Open TODO File")
    "TAB TAB" '(comment-line :wk "Comment lines"))
  (emacs/leader-keys
    "o" '(:ignore t :wk "Org-Mode Commands")
    "o a" '(org-agenda :wk "Org Agenda")
    "o o" '(org-mode :wk "Org Mode"))
  (emacs/leader-keys
    "c" '(:ignore t :wk "Compile Commands")
    "c c" '(compile-c-cpp-program :wk "Compile C/C++ Prorgam"))
  (emacs/leader-keys
    "r" '(:ignore t :wk "Run Commands")
    "r c" '(run-c-cpp-program :wk "Run C/C++ Executable")
    "r p" '(run-python-program :wk "Run Python Program"))
  (emacs/leader-keys
    ";" '(:ignore t :wk "Bookmark Options")
    "; b" '(bookmark-jump :wk "Quickly Jump to a Bookmark")
    "; a" '(bookmark-set :wk "Create a Bookmark")
    "; d" '(bookmark-delete :wk "Delete a Saved Bookmark"))
  (emacs/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
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
    "t v" '(visual-line-mode :wk "Toggle to View truncated lines")))

(use-package sudo-edit
  :ensure t
  :bind ("s-e" . sudo-edit))

(setq org-directory "~/dox/orgs/org-agenda")
(setq org-agenda-files '("tasks.org"))
;; If you only want to see the agenda for today
;; (setq org-agenda-span 'day)
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))
(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 7)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))
          (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

        ("n" "Next Tasks"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))


        ("W" "Work Tasks" tags-todo "+work")

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))

        ("w" "Workflow Status"
         ((todo "WAIT"
                ((org-agenda-overriding-header "Waiting on External")
                 (org-agenda-files org-agenda-files)))
          (todo "REVIEW"
                ((org-agenda-overriding-header "In Review")
                 (org-agenda-files org-agenda-files)))
          (todo "PLAN"
                ((org-agenda-overriding-header "In Planning")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "BACKLOG"
                ((org-agenda-overriding-header "Project Backlog")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "READY"
                ((org-agenda-overriding-header "Ready for Work")
                 (org-agenda-files org-agenda-files)))
          (todo "ACTIVE"
                ((org-agenda-overriding-header "Active Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "COMPLETED"
                ((org-agenda-overriding-header "Completed Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "CANC"
                ((org-agenda-overriding-header "Cancelled Projects")
                 (org-agenda-files org-agenda-files)))))))

(setq org-hide-emphasis-markers t)
(require 'org)
;; Function to set Liberation Sans font for Org mode buffers
(defun set-org-buffer-font ()
  (face-remap-add-relative 'default '(:family "Liberation Sans")))

;; Add the hook to apply the font for Org mode buffers
(add-hook 'org-mode-hook 'set-org-buffer-font)


;; Define font faces
(defface org-title-face
  '((t (:inherit default :height 600 :underline nil :weight bold :font "Rothenburg Decorative")))
  "Face for the org document title")
(defface org-heading-face
  '((t (:inherit default :family "URW Gothic")))
  "Face for org headings")

;; Set font faces for org levels
(custom-theme-set-faces
 'user
 '(org-level-8 ((t (:inherit org-heading-face :height 1.2))))
 '(org-level-7 ((t (:inherit org-heading-face :height 1.2))))
 '(org-level-6 ((t (:inherit org-heading-face :height 1.2))))
 '(org-level-5 ((t (:inherit org-heading-face :height 1.2))))
 '(org-level-4 ((t (:inherit org-heading-face :height 1.4))))
 '(org-level-3 ((t (:inherit org-heading-face :height 1.4))))
 '(org-level-2 ((t (:inherit org-heading-face :height 1.6))))
 '(org-level-1 ((t (:inherit org-heading-face :weight bold :height 1.9))))
 '(org-document-author ((t (:inherit org-author-face))))
 '(org-document-title ((t (:inherit org-title-face)))))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/dox/orgs/roam-notes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))
(use-package org-roam-ui)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode) 
(add-hook 'org-mode-hook 'variable-pitch-mode) 
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
