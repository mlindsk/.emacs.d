;; [[file:~/.emacs.d/setup_files/setup_isearch.org::*Isearch][Isearch:1]]
;; (setq lazy-highlight-cleanup nil) ;;  after C-s the words are still highlighted
 (setq search-highlight t)
 (setq isearch-lazy-highlight t)
 ;; (setq search-whitespace-regexp ".*?")

 ;; Lets be honest; no one can have pinky on CTRL while index finger on r!
 ;; (global-set-key (kbd "C-f") 'isearch-backward)
 ;; (define-key isearch-mode-map "\C-f" 'isearch-repeat-backward)

 ;; From 5.27 How do I show which parenthesis matches the one I'm looking at?
 (defun match-paren (arg)
   "Go to the matching paren if on a paren; otherwise insert %."
   (interactive "p")
   (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
	 ((looking-at "\\s)") (forward-char 1) (backward-list 1))
	 (t (self-insert-command (or arg 1)))))
;; https://emacs.stackexchange.com/questions/52549/get-emacs-to-jump-to-the-start-of-a-word-after-isearch
(define-key isearch-mode-map (kbd "<C-return>")
  (defun isearch-done-opposite (&optional nopush edit)
    "End current search in the opposite side of the match."
    (interactive)
    (funcall #'isearch-done nopush edit)
    (when isearch-other-end (goto-char isearch-other-end))))

;; All of the following variables were introduced in Emacs 27.1.
;; (setq isearch-lazy-count t)
;; (setq lazy-count-prefix-format "(%s/%s) ")
;; (setq lazy-count-suffix-format nil)
;; (setq isearch-yank-on-move 'shift)
;; (setq isearch-allow-scroll 'unlimited)
;; Isearch:1 ends here
