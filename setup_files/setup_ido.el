;; [[file:~/.emacs.d/setup_files/setup_ido.org::*Ido][Ido:1]]
;; Quick switch buffer
 (ido-mode 1)
 (ido-grid-mode 1)

 (setq 
   ido-everywhere t
   ido-separator " | "
   ido-enable-flex-matching  t)

 (defun ido-ignore-dired-buffers (name)
   "Ignore dired buffers"
       (with-current-buffer name
	 (derived-mode-p 'dired-mode)))
 (add-to-list 'ido-ignore-buffers 'ido-ignore-dired-buffers)

 (setq ido-file-extensions-order '(".R" ".Rmd" ".cpp" ".org"))

 (defun ido-vertical-please (o &rest args)
   (let ((ido-grid-mode-max-columns 1)
         (ido-grid-mode-max-rows 15) ;; bigger list than usual
         (ido-grid-mode-min-rows 1) ;; let it shrink
         (ido-grid-mode-start-collapsed nil) ;; pop up tall at the start
         ;; why not have a different prefix as well?
         (ido-grid-mode-prefix ":: "))
     (apply o args)))

(advice-add 'projectile-find-file :around #'ido-vertical-please)
;; Ido:1 ends here
