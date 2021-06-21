;; [[file:~/.emacs.d/setup_files/setup_auctex.org::*Auctex][Auctex:1]]
(with-eval-after-load 'latex

  ;; Jump to pdf/soure (C-c v and point and click)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
  (setq TeX-source-correlate-start-server t)
  ;; Remove sub and superscript sepcial fonting
  (setq font-latex-fontify-script nil)

  ;; Turn on RefTeX
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-auctex t)

  ;; Turn on math mode - prefix with "`"
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

  ;; Automatically make braces and jump in the middle of these
  (add-hook 'LaTeX-mode-hook 'latex_sup_sript)
  (defun latex_sup_sript ()
    (require 'tex-site)
    (define-key LaTeX-mode-map "^" 
      (lambda () 
	(interactive) 
	(if (equal (preceding-char) ?^) 
	    (progn (insert "{}")(backward-char)) 
	  (insert "^")))))
  (add-hook 'LaTeX-mode-hook 'latex_sub_sript)
  (defun latex_sub_sript ()
    (require 'tex-site)
    (define-key LaTeX-mode-map "_" 
      (lambda () 
	(interactive) 
	(if (equal (preceding-char) ?_) 
	    (progn (insert "{}")(backward-char)) 
	  (insert "_")))))

  ;; Open pdf with system pdf viewer (works on mac)
  (setq bibtex-completion-pdf-open-function
    (lambda (fpath)
     (start-process "open" "*open*" "open" fpath)))
)
;; Auctex:1 ends here
