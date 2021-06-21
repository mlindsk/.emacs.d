;; [[file:~/.emacs.d/setup_files/setup_dired.org::*Dired][Dired:1]]
;; enter new directory with "a"
(put 'dired-find-alternate-file 'disabled nil)

;; Show folders first
(setq dired-listing-switches "-agho --group-directories-first"
      dired-omit-files "^\\.[^.].*"
      dired-omit-verbose nil)

;; https://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
 ))

;; Copy (C) or Rename/Move (R) from window to window
(setq dired-dwim-target t) 

;; (require 'dired-x)
;; (setq dired-listing-switches "-alh") ;; Human readable size format

;; Hide details per default - Bound to C-( 
(add-hook 'dired-mode-hook
  (lambda ()
    (dired-hide-details-mode)))

;; https://github.com/Fuco1/dired-hacks
;; Dired-subtree and peep-dired
(eval-after-load "dired" '(progn
  (require 'dired-subtree)
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)
  (define-key dired-mode-map (kbd "<C-tab>") 'dired-subtree-remove)
  (define-key dired-mode-map (kbd "P") 'peep-dired)))

(setq peep-dired-cleanup-on-disable t)
(setq peep-dired-ignored-extensions '("mp4" "pdf" "png"))
;; Dired:1 ends here
