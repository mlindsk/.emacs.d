;; [[file:~/.emacs.d/setup_files/setup_orgmode.org::*Orgmode][Orgmode:1]]
(with-eval-after-load 'org-mode
    (setq org-todo-keywords
	  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "IF-TIME")))

    (require 'ob-shell)
    (require 'ox-md)

    ;; Other blocks
    (org-babel-do-load-languages
     'org-babel-load-languages
     '(
       (R . t)
       (C . t)
       (dot . t)     ;; For grapviz
       (python . t)
       (scheme . t)
       (latex . t)
       (shell . t)
       (ditaa . t)
       (calc . t)
       ))

    ;; Dont ask for execution
    (setq org-confirm-babel-evaluate nil)

    ;; Indentation
    (setq org-cycle-separator-lines 2)
    (setq org-indent-indentation-per-level 0)

    ;; Agendas
    (global-set-key "\C-ca" 'org-agenda)

    ;; Default LaTeX export packages
    (setq org-latex-packages-alist '(("margin=2cm" "geometry" nil)))

    ;; Graphviz
    ;; https://stackoverflow.com/questions/16770868/org-babel-doesnt-load-graphviz-editing-mode-for-dot-sources
    (add-to-list 'org-src-lang-modes (quote ("dot" . graphviz-dot)))

    ;; Inline image settings
    (setq org-image-actual-width nil)

    ;; (require `org-ref)
    ;; (setq reftex-default-bibliography '("~/Documents/phd/litterature/global_cite.bib"))
    ;; (setq org-ref-bibliography-notes "~/Documents/phd/litterature/global_notes.org"
    ;;   org-ref-default-bibliography '("~/Documents/phd/litterature/global_cite.bib")
    ;;   org-ref-pdf-directory "~/Documents/phd/litterature/papers/")

    ;; (defun bibAliases ()
    ;;  (local-set-key (kbd "C-c q") 'doi-utils-add-entry-from-crossref-query)
    ;;  (local-set-key (kbd "C-c w") 'helm-bibtex-with-local-bibliography)
    ;;  (local-set-key (kbd "C-c e") 'org-ref-bibtex-hydra/body))
    ;; (add-hook 'bibtex-mode-hook 'bibAliases)

    ;; FONTIFICATION:
    ;; https://github.com/integral-dw/org-superstar-mode

    ;; http://pragmaticemacs.com/page/2/
    (setq org-highlight-latex-and-related '(latex))
    ;; https://zzamboni.org/post/beautifying-org-mode-in-emacs/
    (font-lock-add-keywords 'org-mode
			    '(("^ *\\([-]\\) "
			       (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

    (add-hook 'org-mode-hook (lambda() (org-bullets-mode 1)))
    (setq org-src-fontify-natively t)
    (setq org-fontify-whole-heading-line t)
    (setq org-hide-emphasis-markers t)

  ;; Fontify Headline
    (custom-set-faces
      '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
      '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
      '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
      '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
    )

   ;; Fontify Custom Faces
    (custom-theme-set-faces
     'user
     '(org-block                 ((t (:inherit fixed-pitch))))
     '(org-document-info         ((t (:foreground "dark orange"))))
     '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
     '(org-link                  ((t (:foreground "light blue" :underline t))))
     '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
     '(org-property-value        ((t (:inherit fixed-pitch))) t)
     '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
     '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
     '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))
     '(org-indent                ((t (:inherit (org-hide fixed-pitch))))))

  ) ;; end with-eval-after-load
;; Orgmode:1 ends here
