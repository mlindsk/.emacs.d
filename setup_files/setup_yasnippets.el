;; [[file:~/.emacs.d/setup_files/setup_yasnippets.org::*Yasnippets][Yasnippets:1]]
(with-eval-after-load 'ess
  (autoload 'yasnippet "yasnippet" "" t)
  (require 'yasnippet)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
) ;; end with-eval-after-load
;; Yasnippets:1 ends here
