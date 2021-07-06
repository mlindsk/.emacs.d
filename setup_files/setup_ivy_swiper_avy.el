;; [[file:~/.emacs.d/setup_files/setup_ivy_swiper_avy.org::*Ivy,%20Swiper%20and%20Avy][Ivy, Swiper and Avy:1]]
(ivy-mode 1)
(setq ivy-count-format ""
      ivy-height 3
      ivy-display-style nil
      ivy-minibuffer-faces nil)
(global-set-key (kbd "C-s") 'swiper-isearch)

(add-hook 'org-mode-hook
  (lambda ()
  (local-unset-key (kbd "C-'"))))

(global-set-key (kbd "C-'") 'avy-goto-char)
(global-set-key (kbd "C-:") 'avy-goto-char-2)
;; Ivy, Swiper and Avy:1 ends here
