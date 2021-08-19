;; [[file:~/.emacs.d/setup_files/setup_csharp.org][No heading:1]]
(with-eval-after-load "julia-mode"
 
  ;; Starting a script; run the command "M-x lsp"
  ;; compile: mcs "filename.cs"
  ;; run: mono "filename.cs"

  (require 'csharp-mode)
  (require 'lsp-mode)
  (add-hook 'csharp-mode-hook #'lsp)

)
;; No heading:1 ends here
