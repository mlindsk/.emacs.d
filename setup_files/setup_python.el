;; (with-eval-after-load 'python-mode

;; Jedi: code completion framework for python; use it with company-jedi

;; needs: pip3 install virtualenv
(setq python-shell-interpreter "python3")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; Isend
(require 'isend-mode)
;; (add-hook 'isend-mode-hook 'isend-default-python-setup)

;; Highlight eldoc params
(defun ted-frob-eldoc-argument-list (string)
  "Upcase and fontify STRING for use with `eldoc-mode'."
   (propertize (upcase string)
             'face 'font-lock-variable-name-face))
(setq eldoc-argument-case 'ted-frob-eldoc-argument-list)

;; Python mode
(defun my-python-hooks()
    (interactive)
    (setq tab-width     2
	  python-indent 2
	  python-shell-interpreter "ipython"
	  python-shell-interpreter-args "--simple-prompt -i")
    ;; python mode keybindings
    (define-key python-mode-map (kbd "M-.") 'jedi:goto-definition)
    (define-key python-mode-map (kbd "M-,") 'jedi:goto-definition-pop-marker)
    (define-key python-mode-map (kbd "M-/") 'jedi:show-doc)
    (define-key python-mode-map (kbd "M-?") 'helm-jedi-related-names)
    (define-key python-mode-map (kbd "C-c a") 'isend-associate)
    (define-key python-mode-map [(shift return)] 'isend-send)
    )

(add-hook 'python-mode-hook 'my-python-hooks)


(defun clear-repl ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(add-hook 'inferior-python-mode-hook (lambda () (local-set-key (kbd "C-c l") 'clear-repl)))

;; Font lock
(font-lock-add-keywords 'python-mode
  '(("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)  ; adds object and str and fixes it so that keywords that often appear with : are assigned as builtin-face
  ("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face) ; FIXME: negative or positive prefixes do not highlight to this regexp but does to one below
  ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'widget-inactive-face)))
