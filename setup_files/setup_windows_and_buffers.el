;; [[file:~/.emacs.d/setup_files/setup_windows_and_buffers.org::*Windows%20and%20Buffers][Windows and Buffers:1]]
;; Quickly switch between the two recent visited filed
(global-set-key (kbd "C-p")
    (lambda () (interactive "")
      (switch-to-buffer (other-buffer (current-buffer) t))))

(define-key global-map [f1] 'other-window)
(define-key global-map [f2] 'delete-window)
(global-set-key (kbd "<f3>") 'find-file-other-frame) ;; Open file in new frame: C-x 5 f
(defun my-bookmark-jump-other-frame (bookmark)
  (interactive
   (list (bookmark-completing-read "Jump to bookmark (in another frame)"
				   bookmark-current-bookmark)))
  (bookmark-jump bookmark 'switch-to-buffer-other-frame))
(global-set-key (kbd "<f4>") 'my-bookmark-jump-other-frame)

(require 'buffer-move)
(global-set-key (kbd "M-S-<up>")     'buf-move-up)
(global-set-key (kbd "M-S-<down>")   'buf-move-down)
(global-set-key (kbd "M-S-<left>")   'buf-move-left)
(global-set-key (kbd "M-S-<right>")  'buf-move-right)

;; "M-arrows"
(windmove-default-keybindings 'meta)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
;; Windows and Buffers:1 ends here
