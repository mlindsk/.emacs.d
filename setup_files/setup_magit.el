;; [[file:~/.emacs.d/setup_files/setup_magit.org::*Magit][Magit:1]]
(global-set-key (kbd "C-x g") 'magit-status)

  ;; Full screen
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
       ad-do-it
    (delete-other-windows))

;; Dont save those annoying buffers
(defun mu-magit-kill-buffers ()
  "Restore window configuration and kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (magit-restore-window-configuration)
    (mapc #'kill-buffer buffers)))

(eval-after-load "magit" '(progn
    (define-key magit-mode-map (kbd "q") 'mu-magit-kill-buffers)))
;; Magit:1 ends here
