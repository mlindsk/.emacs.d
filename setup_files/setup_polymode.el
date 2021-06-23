;; [[file:~/.emacs.d/setup_files/setup_polymode.org::*Polymode][Polymode:1]]
(with-eval-after-load 'poly-markdown+r-mode

  (require 'poly-R)
  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
  (add-to-list 'auto-mode-alist '("\\.Rcpp" . poly-r+c++-mode))
  (add-to-list 'auto-mode-alist '("\\.cppR$" . poly-c++r-mode))
  (add-to-list 'auto-mode-alist '("\\.[jJ]md" . poly-markdown-mode))
  (add-to-list 'polymode-mode-name-override-alist '(julia . ess-julia))
  ;; https://github.com/polymode/poly-R/issues/5
  ;; https://github.com/polymode/polymode/issues/205
  ;; Remove those [exported] names which pandoc cant handle
  (setq polymode-exporter-output-file-format '"%s")

  ;; (global-set-key (kbd "<f11>") 'latex-mode)
  ;; (global-set-key (kbd "<f12>") 'poly-markdown+r-mode)
  ;; (add-hook 'markdown-mode-hook 'markdown-toggle-math)

) ;; end with-eval-after-load
;; Polymode:1 ends here