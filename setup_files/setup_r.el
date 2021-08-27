;; [[file:~/.emacs.d/setup_files/setup_r.org::*R][R:1]]
(with-eval-after-load 'ess

  (require 'ess-r-mode)
  (define-key ess-r-mode-map [(control return)] nil)
  (define-key ess-r-mode-map [(shift return)] 'ess-eval-region-or-line-and-step)

  ;; Remove smart-underscore and asign <- to another key
  (add-hook 'ess-r-mode-hook (lambda () (local-set-key (kbd "C-;") "<-")))
  (add-hook 'inferior-ess-r-mode-hook (lambda () (local-set-key (kbd "C-;") "<-")))

  ;; Pipe operator
  (add-hook 'ess-r-mode-hook (lambda () (local-set-key (kbd "C-%") "%>%"))) 
  (add-hook 'inferior-ess-r-mode-hook (lambda () (local-set-key (kbd "C-%") "%>%")))


  ;; Some styling
  (defun highlight-todos ()
  "Customize R-mode."
  (interactive)
  (font-lock-add-keywords nil
			'(("\\<\\(FIXME\\|TODO\\|QUESTION\\|NOTE\\)"
			   1 font-lock-warning-face t))))

  (add-hook 'ess-r-mode-hook (lambda () (highlight-todos)))

  (require 'whitespace)
  (setq whitespace-line-column 90)
  (setq whitespace-style '(face lines-tail))
  (add-hook 'ess-r-mode-hook 'whitespace-mode)

  (define-key input-decode-map "\e[1;2A" [S-up])

  ;; Stop using double hashtags for commmenting
  (add-hook 'ess-r-mode-hook
    (lambda () (progn (setq comment-start "# ")
                      (setq comment-add 0))))

;; Terminate session with C-c C-q and dont ask me to save. And dont write .Rhistory!			
(setq inferior-R-args "--no-restore-history --no-save")
(setq ess-history-file nil)

;; Flymake /(syntax checking)
(setq ess-use-flymake nil)

(setq 
  ess-default-style 'RStudio-
  ess-use-auto-complete nil
  ess-use-company 't
  ess-fancy-comments nil        ; stop using double hashtags when commenting
  ess-indent-with-fancy-comments nil
  ess-toggle-underscore nil     ; stop the (not so) smart underscore
  ess-eval-empty t              ; don't skip non-code lines.
  ess-ask-for-ess-directory nil ; start R in the current working directory by default
  ;; ess-r-package-auto-set-evaluation-env nil ; C-c C-t C-s
  )
  ;; http://permalink.gmane.org/gmane.emacs.ess.general/8419
  ;; Script font lock highlight.
  (setq ess-R-font-lock-keywords
  '((ess-R-fl-keyword:modifiers . t)
  (ess-R-fl-keyword:fun-defs . t)
  (ess-R-fl-keyword:keywords . t)
  (ess-R-fl-keyword:assign-ops . t)
  (ess-R-fl-keyword:constants . t)
  (ess-fl-keyword:fun-calls . t)
  (ess-fl-keyword:numbers . t)
  (ess-fl-keyword:operators . t)
  (ess-fl-keyword:delimiters)
  (ess-fl-keyword:=)
  (ess-R-fl-keyword:F&T . t)
  (ess-R-fl-keyword:%op% . t)
  )
  )

  ;; Console font lock highlight.
  (setq inferior-R-font-lock-keywords
  '((ess-S-fl-keyword:prompt . t)
  (ess-R-fl-keyword:messages . t)
  (ess-R-fl-keyword:modifiers . t)
  (ess-R-fl-keyword:fun-defs . t)
  (ess-R-fl-keyword:keywords . t)
  (ess-R-fl-keyword:assign-ops . t)
  (ess-R-fl-keyword:constants . t)
  (ess-fl-keyword:matrix-labels . t)
  (ess-fl-keyword:fun-calls . t)
  (ess-fl-keyword:numbers . t)
  (ess-fl-keyword:operators . t)
  (ess-fl-keyword:delimiters)
  (ess-fl-keyword:=)
  (ess-R-fl-keyword:F&T . t)
  (ess-R-fl-keyword:%op% . t)
  )
  )
) ;; end with-eval-after-load
;; R:1 ends here
