;; TODO: https://wunki.org/posts/2014-05-17-haskell-packages-development.html
;; https://github.com/chrisdone/chrisdone-emacs/blob/master/config/haskell.el
;; TODO: ghci-ng
;; TODO: don't pop up *Warnings* if haskell-stylish-on-save fails
;; TODO: purescript-mode
(require-package 'haskell-mode)


;; Completion

(when (executable-find "ghci-ng")
  (setq-default haskell-process-args-cabal-repl
                '("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng")))

(when (maybe-require-package 'company-ghci)
  (after-load 'haskell-mode
    (after-load 'company
      (add-hook 'haskell-mode-hook
                (lambda () (sanityinc/local-push-company-backend 'company-ghci))))))



;; Flycheck specifics

(when (and (maybe-require-package 'flycheck-haskell)
           (require-package 'flycheck-hdevtools))
  (after-load 'flycheck
    (add-hook 'haskell-mode-hook #'flycheck-haskell-setup)

    (defun sanityinc/flycheck-haskell-reconfigure ()
      "Reconfigure flycheck haskell settings, e.g. after changing cabal file."
      (interactive)
      (unless (eq major-mode 'haskell-mode)
        (error "Expected to be in haskell-mode"))
      (flycheck-haskell-clear-config-cache)
      (flycheck-haskell-configure)
      (flycheck-mode -1)
      (flycheck-mode))

    (after-load 'haskell-mode
      (require 'flycheck-hdevtools))))



;; Docs

(dolist (hook '(haskell-mode-hook inferior-haskell-mode-hook haskell-interactive-mode-hook))
  (add-hook hook (lambda () (subword-mode +1)))
  (add-hook hook (lambda () (eldoc-mode 1))))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-hook 'haskell-interactive-mode-hook 'sanityinc/no-trailing-whitespace)


;; Interaction

(after-load 'haskell
  (diminish 'interactive-haskell-mode " IntHS"))

(add-auto-mode 'haskell-mode "\\.ghci\\'")

(when (maybe-require-package 'ghci-completion)
  (add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion))



;; Indentation - turned off at the moment
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'hindent-mode)
;; (setq-default hindent-reformat-buffer-on-save t)


;; Source code helpers

(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

(setq-default haskell-stylish-on-save t)

(maybe-require-package 'hayoo)
(after-load 'haskell-mode
  (define-key haskell-mode-map (kbd "C-c h") 'hoogle)
  (define-key haskell-mode-map (kbd "C-o") 'open-line))


(after-load 'page-break-lines
  (push 'haskell-mode page-break-lines-modes))

;; Make compilation-mode understand "at blah.hs:11:34-50" lines output by GHC
(after-load 'compile
  (let ((alias 'ghc-at-regexp))
    (add-to-list
     'compilation-error-regexp-alist-alist
     (list alias " at \\(.*\\.\\(?:l?[gh]hs\\|hi\\)\\):\\([0-9]+\\):\\([0-9]+\\)-[0-9]+$" 1 2 3 0 1))
    (add-to-list
     'compilation-error-regexp-alist alias)))


;; Stop haskell-mode's compiler note navigation from clobbering highlight-symbol-nav-mode
(after-load 'haskell
  (define-key interactive-haskell-mode-map (kbd "M-n") nil)
  (define-key interactive-haskell-mode-map (kbd "M-p") nil)
  (define-key interactive-haskell-mode-map (kbd "M-N") 'haskell-goto-next-error)
  (define-key interactive-haskell-mode-map (kbd "M-P") 'haskell-goto-prev-error))

;; Set up Intero -- don't add a hook though: don't want to use it with nix
(package-install 'intero)
;;(add-hook 'haskell-mode-hook 'intero-mode)

(provide 'init-haskell)
