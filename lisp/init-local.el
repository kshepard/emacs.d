;; highlight selected text
(setq transient-mark-mode 't highlight-nonselected-windows 't)

;; Spaces, not tabs
(setq-default indent-tabs-mode nil)

;; Set color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)

;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;; Remove unnecesarry bars
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Make sure feedback information is available
(setq line-number-mode t)
(setq column-number-mode t)

;; Don't write backup files
(setq make-backup-files nil)

;; Yes, No --> Y, N
(fset 'yes-or-no-p 'y-or-n-p)

;; Custom key bindings
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w"     'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'copy-region-as-kill)
(global-set-key "\M-s"     'isearch-forward-regexp)
(global-set-key "\M-r"     'isearch-backward-regexp)
(global-set-key "\C-xt"    'beginning-of-buffer)
(global-set-key "\C-xe"    'end-of-buffer)
(global-set-key "\C-h"     'backward-delete-char-untabify)
(global-set-key "\M-h"     'help-command)
(global-set-key [f5]       'call-last-kbd-macro)

;; Allow C-h for backspacing while isearching
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)

;; whitespace
(require 'whitespace)

;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; display only tails of lines longer than 100 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 100)
(setq whitespace-style '(face tabs trailing lines-tail))

;; face for long lines' tails
(set-face-attribute 'whitespace-line nil
                    :background "red1"
                    :foreground "yellow"
                    :weight 'bold)

;; face for tabs
(set-face-attribute 'whitespace-tab nil
                    :background "red1"
                    :foreground "yellow"
                    :weight 'bold)

;; activate minor whitespace mode in various languages
(add-hook 'python-mode-hook 'whitespace-mode)
(add-hook 'js2-mode-hook 'whitespace-mode)
(add-hook 'scala-mode-hook 'whitespace-mode)

;; enable various commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq find-program "/usr/bin/find" grep-program "/bin/grep")

(provide 'init-local)
