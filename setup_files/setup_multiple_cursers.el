;; [[file:~/.emacs.d/setup_files/setup_multiple_cursers.org::*Multiple%20Cursers][Multiple Cursers:1]]
(require 'multiple-cursors)
(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m w") 'mc/mark-all-words-like-this)
(global-set-key (kbd "C-c m s") 'mc/mark-all-symbols-like-this)
(global-set-key (kbd "C-c m m") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-c m p") 'mc/mark-pop)
(global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
(define-key mc/keymap (kbd "<return>") nil)
;; Multiple Cursers:1 ends here
