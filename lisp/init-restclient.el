(require 'package)
(package-initialize)
(unless (package-installed-p 'restclient)
  (package-refresh-contents) (package-install 'restclient))

(provide 'init-restclient)
