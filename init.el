;; ---------------------------------------------------------------------------;;
;; -----------------------   GLOBAL SETTINGS   ------------------------------ ;;
;; ---------------------------------------------------------------------------;;
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))

(package-initialize)

;; Load paths
(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")

;; My setup files
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_package_management.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_color_theme.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_global_settings.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_comment_dwim.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_multiple_cursers.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_spell_checking.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_windows_and_buffers.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_shell.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_ibuffer.org"))

;; Interface completion and searching.
;; (org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_ido.org"))     ;; Emacs buil-in completion interface
;; (org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_isearch.org")) ;; Emacs buil-in searching
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_ivy_swiper.org")) ;; A nice alternative

(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_dired.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_visual_regexp.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_expand_region.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_magit.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_projectile.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_yasnippets.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_orgmode.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_auctex.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_polymode.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_julia.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_company.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_cpp.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_r.org"))
;; (org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_xterm.org"))
(org-babel-load-file (expand-file-name "~/.emacs.d/setup_files/setup_end_of_init.org"))

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)