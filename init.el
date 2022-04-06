;; Package repository
;; ------------------
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))

(package-initialize)

;; Load paths
;; ----------
;; (add-to-list 'load-path "~/.emacs.d/elpa/")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/"))
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/elpa/"))

;; My init file
(org-babel-load-file (expand-file-name "~/.emacs.d/lindskou_init.org"))
