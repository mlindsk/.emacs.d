;; [[file:~/.emacs.d/setup_files/setup_julia.org::*Julia][Julia:1]]
;; Enable inputting unicode symbols with TeX commands
;; toggle with C-\
;; (setq default-input-method 'TeX)
(with-eval-after-load "julia-mode"

  (require 'julia-mode)
  (require 'julia-repl)
  (setq julia-indent-offset 2)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
  
  ;; ESS-like keybindings
  (define-key julia-repl-mode-map [(control return)] nil)
  (define-key julia-repl-mode-map [(shift return)] 'julia-repl-send-line)

  (define-key julia-repl-mode-map (kbd "C-c C-d") nil)
  (define-key julia-repl-mode-map (kbd "C-c C-v") 'julia-repl-doc)

  (defun customize-julia-mode ()
    "Customize julia-mode."
    (interactive)
    ;; my customizations go here
    (font-lock-add-keywords nil
                        '(("\\<\\(FIXME\\|TODO\\|QUESTION\\|NOTE\\)"
                           1 font-lock-warning-face t))))

  (add-hook 'julia-mode-hook (lambda () (customize-julia-mode)))
)
;; Julia:1 ends here