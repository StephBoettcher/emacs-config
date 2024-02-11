(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)
(require 'unbound)

(set-face-attribute 'default nil
		    :font "JetBrains Mono"
		    :height 180
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "SF Pro Display"
		    :height 180
		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
		    :font "JetBrains Mono"
		    :height 180
		    :weight 'medium)

;; Make commented text and keywords italics.
;; The font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :slant 'italic)

;; Adjust line spacing
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq ns-use-native-fullscreen t) ;; Use MacOs' native fullscreen
(add-to-list 'initial-frame-alist '(fullscreen . fullscreen)) ;; Force fullscreen window on open
;(add-to-list 'initial-frame-alist '(fullscreen . maximized)) ;; Force maximized window on open

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(delete-selection-mode 1)

(electric-pair-mode 1)

(global-auto-revert-mode t)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(use-package doom-themes
:config
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)
(doom-themes-neotree-config) ;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-org-config)) ;; Corrects (and improves) org-mode's native fontification.

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package beacon
  :ensure t
  :diminish
  :config (beacon-mode 1))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;;(setq dashboard-startup-banner (concat user-emacs-directory "images/dtmacs-logo.png"))  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 'nil' for aligned-left content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))

  :config
  (dashboard-modify-heading-icons '((recents . "file-text")
                            (bookmarks . "book")))
  (dashboard-setup-startup-hook))

(use-package diminish)

(use-package git-timemachine)

(use-package golden-ratio
  :ensure t
  :hook (after-init . golden-ratio-mode)
  :custom (golden-ratio-exclude-modes '(occur-mode)))

(use-package counsel
  :after ivy
  :diminish
  :config 
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

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
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer))

(use-package transient) ;; required package for magit
(use-package magit)

(use-package neotree
:bind ("<f5>" . neotree-toggle)
:config
(setq neo-smart-open t
      neo-show-hidden-files t
      neo-window-width 55
      neo-window-fixed-size nil
      inhibit-compacting-font-caches t
      projectile-switch-project-action 'neotree-projectile-action) 
      ;; truncate long file names in neotree
      (add-hook 'neo-after-create-hook
         #'(lambda (_)
             (with-current-buffer (get-buffer neo-buffer-name)
               (setq truncate-lines t)
               (setq word-wrap nil)
               (make-local-variable 'auto-hscroll-mode)
               (setq auto-hscroll-mode nil)))))

(use-package toc-org
  :commands toc-org-enable
  :init
  (add-hook 'org-mode-hook 'toc-org-enable)
  (add-hook 'org-mode-hook 'org-indent-mode))

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-tempo)

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))
(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)))

(use-package projectile
  :diminish
  :config
  (projectile-mode 1))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(setq vterm-always-compile-module t)
(use-package vterm
  :config
  (setq shell-file-name "/bin/sh"
        vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package spacious-padding
  :ensure t
  :hook (after-init . spacious-padding-mode))

(use-package sudo-edit)

(use-package tldr)



(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → "))
