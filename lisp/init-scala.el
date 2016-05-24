(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode)
  (package-refresh-contents) (package-install 'scala-mode))


(provide 'init-scala)
