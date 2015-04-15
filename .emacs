;; A lighter-weight init.el for 24

(require 'package)
(package-initialize)

;; stable packages first
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-refresh-contents)

(dolist (p '(cider clojure-mode))
  (when (not (package-installed-p p))
    (package-install p)))

;; bleeding edge
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-refresh-contents)
(dolist (p '(better-defaults
             idle-highlight-mode
             elisp-slime-nav
             paredit
             smex
             find-file-in-project
             magit
             zenburn-theme))
  (when (not (package-installed-p p))
    (package-install p)))

(setq-default ispell-program-name "aspell")

(setq magit-last-seen-setup-instructions "1.4.0")

;; pretty colors
(load-theme 'zenburn t)
(set-face-foreground 'vertical-border "white")
(when (<= (display-color-cells) 8)
  (defun hl-line-mode () (interactive)))

;; some useful settings
(column-number-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; bindings

;; Why would you ever background Emacs?
(global-set-key (kbd "C-z") (lambda () (interactive)
                              (message "Nope.")))

(global-set-key (kbd "C-c f") 'find-file-in-project)

(add-hook 'prog-mode-hook
          (defun my-kill-word-key ()
            (local-set-key (kbd "C-M-h") 'backward-kill-word)))

(global-set-key (kbd "C-M-h") 'backward-kill-word)

(global-set-key (kbd "C-x C-i") 'imenu)

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2)))

(global-set-key (kbd "C-x m") 'shell)
(global-set-key (kbd "C-x C-m") 'eshell)

(global-set-key (kbd "C-c q") 'join-line)
(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key (kbd "C-c n")
                (defun my-cleanup-buffer () (interactive)
                       (delete-trailing-whitespace)
                       (untabify (point-min) (point-max))
                       (indent-region (point-min) (point-max))))

(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

;;; eshell

(defun eshell/rgrep (&rest args)
  "Use Emacs grep facility instead of calling external grep."
  (eshell-grep "rgrep" args t))

(defun eshell/cdg ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory ".git")))

;;; programming

(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(add-hook 'clojure-mode-hook 'paredit-mode)

(add-hook 'nrepl-connected-hook
          (defun my-clojure-mode-eldoc-hook ()
            (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)))

(setq whitespace-style '(face trailing lines-tail tabs))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
