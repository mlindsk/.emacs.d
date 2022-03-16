(with-eval-after-load "paradox"
  (require 'paradox)
  (paradox-enable)
  ;; M-x paradox-list-packages
)

;; Color Theme - https://github.com/bbatsov/zenburn-emacs

;; Old colors (Good for ESS)
;;  (setq zenburn-override-colors-alist
;;  '(("zenburn-yellow" . "#8FD878")
;;  ("zenburn-cyan"     . "#F0D278")))

(setq zenburn-override-colors-alist
'(
  ("zenburn-yellow" . "#DEC787")
  ("zenburn-cyan"   . "#70BFC2")
  ;; ("zenburn-fg"     . "#f2f0f0") ;; A little brighter text in general
  ;;("zenburn-bg+3"     . "#b33939")
))

(require 'kaolin-themes)
(load-theme 'zenburn t)

(setq mads/themes '(
zenburn
kaolin-valley-light
doom-nord-light
doom-solarized-light
doom-zenburn
))

(setq mads/themes-index 0)

(defun mads/cycle-theme ()
  (interactive)
  (setq mads/themes-index (% (1+ mads/themes-index) (length mads/themes)))
  (mads/load-indexed-theme))

(defun mads/load-indexed-theme ()
  (mads/try-load-theme (nth mads/themes-index mads/themes)))

(defun mads/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

(global-set-key [f5] 'mads/cycle-theme)

;; Backup Files
 (setq make-backup-files nil)          ;; stop creating those backup ~ files
 (setq auto-save-default nil)          ;; stop creating those #auto-save# files
 (setq auto-save-list-file-prefix nil) ;; Stop creating auto-save-list folder

 ;; When emacs starts, maximize the window
 (set-frame-parameter (selected-frame) 'fullscreen 'maximized)

 ;; Redefining undo and paste (yank)
 (global-unset-key "\C-z")
 (global-set-key "\C-z" 'undo)
 (global-set-key [?\C-v] 'clipboard-yank)
 (defun yank-pop-forwards (arg)
   (interactive "p")
     (yank-pop (- arg)))
 (global-set-key "\M-Y" 'yank-pop-forwards)

 ;; Remove scroll bare and the grey area around it
 (scroll-bar-mode 0)
 (set-fringe-mode 5)

 ;; Remote stuff
 (setq tramp-default-method "ssh")
 ;; https://www.dcalacci.net/2018/remote-ess/
 ;; https://www.r-bloggers.com/run-a-remote-r-session-in-emacs-emacs-ess-r-ssh/

 ;; https://emacs.stackexchange.com/questions/5553/
 ;; async-shell-process-buffer-always-clobbers-window-arrangement
 ;; (Calling external programs with M-! makes a lot of unwanted results) 
 (add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

 (global-set-key (kbd "C-c h") 'helm-show-kill-ring)
 (global-set-key (kbd "C-x k") 'kill-this-buffer) ;; Kill this buffer - instead of selecting.
 (fset 'yes-or-no-p 'y-or-n-p)                    ;; Avoid typing yes and no
 (set-cursor-color "#ffffff") 
 ; (require 'smooth-scrolling)
 ; (smooth-scrolling-mode 1)
 ; (setq smooth-scroll-margin 5)
 (delete-selection-mode 1)                      ;; Make typing delete/overwrites selected text
 ;; (setq frame-title-format "%b")              ;; Filename in titlebar
 (menu-bar-mode -1)                             ;; Remove menu bar: Shortcut = F10
 (tool-bar-mode -1)                             ;; Remove copy/paste etc. bar
 (set-face-attribute 'default nil :height 160)  ;; Font size (1/10pt)
 (winner-mode t)                                ;; Store window configurations and load them back
 (global-visual-line-mode 1)                    ;; Wrapping lines nicely
 (electric-pair-mode)                           ;; Auto-closing parentheses
 (setq electric-pair-preserve-balance nil)      ;; Auto-closing braces
 (show-paren-mode 1)                            ;; Turn on parenthesis-highlighting
 (setq column-number-mode t)
 (put 'upcase-region 'disabled nil)             ;; Dont ask when upcase or downcase
 (put 'downcase-region 'disabled nil)
 (global-set-key (kbd "C-x f") 'find-file-at-point) ;;open included files at point
 (global-set-key (kbd "C-x p") 'point-to-register) ;; jumpt to buffer position using registers
 (global-set-key (kbd "C-x j") 'jump-to-register)

 (global-set-key (kbd "<f12>") 'compile)

;; set transparency
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(90 . 90) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(beacon-mode 1)

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
    (comment-normalize-vars)
      (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
        (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

(require 'multiple-cursors)
(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m w") 'mc/mark-all-words-like-this)
(global-set-key (kbd "C-c m s") 'mc/mark-all-symbols-like-this)
(global-set-key (kbd "C-c m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m m") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-c m p") 'mc/mark-pop)
(global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
(define-key mc/keymap (kbd "<return>") nil)

;; (require 'dired-sidebar)

;;  (require 'treemacs)
;;  (global-set-key (kbd "C-t") 'treemacs-display-current-project-exclusively)
;;  (setq treemacs-width 25)
;;
;;  ;; Requires all-the-icons and then M-x all-the-icons-istall-fonts
;;  (load "~/.emacs.d/elpa/all-the-icons-dired-20210614.1350/all-the-icons-dired.el")
;;  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(require 'telephone-line)
(setq telephone-line-primary-left-separator 'telephone-line-abs-left
    telephone-line-secondary-left-separator 'telephone-line-abs-hollow-left
    telephone-line-primary-right-separator 'telephone-line-abs-right
    telephone-line-secondary-right-separator 'telephone-line-abs-hollow-right)
(setq telephone-line-height 24
    telephone-line-evil-use-short-tag t)

(if (eq system-type 'gnu/linux)
  (telephone-line-mode 1))

;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; find aspell and hunspell automatically
(cond
 ;; try hunspell at first
  ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
	;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
	;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
	'(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))

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

(if (eq system-type 'windows-nt)
    ;; https://colhountech.com/2016/07/12/how-to-install-ubuntu-fonts-on-windows-10/
     (add-to-list 'default-frame-alist '(font . "Ubuntu Mono-16.0"))    
 )

 ;; Alternatively use browse-url-of-dired-file in dired mode, bound to W
  (if (eq system-type 'windows-nt)
      (global-set-key (kbd "C-c C-q") (lambda () (interactive) (shell-command "explorer .")))
      (global-set-key (kbd "C-c C-q") (lambda () (interactive) (shell-command "nautilus . &"))))

 (if (eq system-type 'windows-nt)
     (global-set-key (kbd "C-c q")   (lambda () (interactive) (shell-command "wt -d ."))) ;; Install WindowsTerminal
   (global-set-key (kbd "C-c q")   (lambda () (interactive) (shell-command "gnome-terminal"))))

 ;; Eshell
 ;; https://www.masteringemacs.org/article/complete-guide-mastering-eshell

(global-set-key (kbd "C-x C-b") 'ibuffer)
  (setq ibuffer-saved-filter-groups
    (quote (("home"
      ("programming" (or
         (mode . python-mode)
	 (mode . c++-mode)
	 (mode . ess-r-mode)))
      ("iESS"   (or
                (name . "^\\*R[:]?")
		(name . "^\\*ESS\\*$")
		(name . "\\*help\\[R\\]")))
      ("latex"  (name . "^.*tex"))
      ("org"    (name . "^.*org$"))
      ("markup" (or
                (name . "^.*[R]?md$")))
      ("shell" (or 
         (mode . eshell-mode) 
         (mode . shell-mode)))
      ("magit" (or
         (name . "^\\*magit")
	 (name . "^magit")))
      ("junk" (or
         (name . "^\\*scratch\\*$")
         (name . "^\\*Messages\\*$")
         (name . "^\\*Flymake log\\*$")))
      ("dired" (mode . dired-mode))
      ))))

  (add-hook 'ibuffer-mode-hook
    (lambda ()
      ;; Automatically updates the buffer list
      (ibuffer-auto-mode 1)
      (ibuffer-switch-to-saved-filter-groups "home")))

  ;; Dont ask for confirmation about killing buffers
  (setq ibuffer-expert t)

  ;; Dont show empty filter groups
  (setq ibuffer-show-empty-filter-groups nil)

;; enter new directory with "a"
(put 'dired-find-alternate-file 'disabled nil)

(add-hook 'dired-mode-hook (lambda () (text-scale-increase 1.5)))

;; Show folders first
; (setq dired-listing-switches "-agho --group-directories-first"
;	dired-omit-files "^\\.[^.].*"
; 	dired-omit-verbose nil)

;; https://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(if (eq system-type 'windows-nt)
  (add-hook 'dired-mode-hook
     (lambda ()
      (define-key dired-mode-map (kbd "\S-q")
        (lambda () (interactive) (find-alternate-file "..")))
     ))
  (add-hook 'dired-mode-hook
     (lambda ()
      (define-key dired-mode-map (kbd "\S-q") ;; (kbd "^")
        (lambda () (interactive) (find-alternate-file ".."))))))


;; Copy (C) or Rename/Move (R) from window to window
(setq dired-dwim-target t) 

;; (require 'dired-x)
;; (setq dired-listing-switches "-alh") ;; Human readable size format

;; Hide details per default - Bound to C-( 
(add-hook 'dired-mode-hook
  (lambda ()
    (dired-hide-details-mode)))

;; https://github.com/Fuco1/dired-hacks
;; Dired-subtree and peep-dired
;; (eval-after-load "dired" '(progn
;;   (require 'dired-subtree)
;;   (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)
;;   (define-key dired-mode-map (kbd "<C-tab>") 'dired-subtree-remove)
;;   (define-key dired-mode-map (kbd "P") 'peep-dired)))

;; (setq peep-dired-cleanup-on-disable t)
;; (setq peep-dired-ignored-extensions '("mp4" "pdf" "png"))

(require 'visual-regexp-steroids)
;; (define-key global-map (Kbd "???") 'vr/replace)
(define-key global-map (kbd "C-M-%") 'vr/query-replace)

;; Annoying redefinition warning
(setq ad-redefinition-action 'accept)
(require 'expand-region)
(global-set-key (kbd "C-(") 'er/expand-region)
(global-set-key (kbd "C-)") 'er/mark-outside-pairs)

(with-eval-after-load 'org

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


    (setq org-todo-keywords
	  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "IF-TIME")))

    ;; Agendas
    ;; (global-set-key "\C-ca" 'org-agenda)

    ;; Default LaTeX export packages
    (setq org-latex-packages-alist '(("margin=2cm" "geometry" nil)))

    ;; Capture
    (define-key global-map (kbd "C-c c") 'org-capture)
    (setq org-default-notes-file "/home/mads/Documents/notes/notes.org")
    (defun my/style-org-agenda()
      (set-face-attribute 'org-agenda-date nil :height 1.1)
      (set-face-attribute 'org-agenda-date-today nil :height 1.1 :slant 'italic)
      (set-face-attribute 'org-agenda-date-weekend nil :height 1.1))

    (add-hook 'org-agenda-mode-hook 'my/style-org-agenda)
    

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

(ivy-mode 1)
(setq ivy-count-format ""
      ivy-height 5
      ivy-display-style nil
      ivy-minibuffer-faces nil)

(global-set-key (kbd "C-S") 'swiper-isearch)

(add-hook 'org-mode-hook
  (lambda ()
  (local-unset-key (kbd "C-'"))))

(global-set-key (kbd "C-'") 'avy-goto-char)
(global-set-key (kbd "C-:") 'avy-goto-char-2)

(global-set-key (kbd "C-x g") 'magit-status)

  ;; Full screen
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
       ad-do-it
    (delete-other-windows))

;; Dont save those annoying buffers
(defun mu-magit-kill-buffers ()
  "Restore window configuration and kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (magit-restore-window-configuration)
    (mapc #'kill-buffer buffers)))

(eval-after-load "magit" '(progn
    (define-key magit-mode-map (kbd "q") 'mu-magit-kill-buffers)))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(with-eval-after-load 'ess
  (autoload 'yasnippet "yasnippet" "" t)
  (require 'yasnippet)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
) ;; end with-eval-after-load
(with-eval-after-load 'python
  (autoload 'yasnippet "yasnippet" "" t)
  (require 'yasnippet)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
) ;; end with-eval-after-load

;; https://stackoverflow.com/questions/49232454/emacs-ess-how-to-auto-complete-library-function
;; Auto-completion - install "company"
;; http://company-mode.github.io/
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-backends '(company-capf))

(setq company-idle-delay 999 ;; How long to wait before popping up
      ; company-minimum-prefix-length 2 ;; Show the menu after one key press
      ; company-tooltip-limit 15 ;; Limit on how many options to display
      ; company-show-numbers t ;; Show numbers behind options
      ; company-tooltip-align-annotations t ;; Align annotations to the right
      ; company-require-match nil ;; Allow free typing
      )
;; Tab complete arguments inside functions (ESS)
(global-set-key (kbd "<backtab>") 'company-complete-common)

;; (set-face-attribute 'company-tooltip-common nil
 ;; :foreground "orange"
 ;; :background "black"
 ;; :weight 'bold)

 ;; (set-face-attribute 'company-tooltip nil
 ;; :foreground "red"
 ;; :background "white"
 ;; :weight 'bold)

;; (set-face-attribute 'font-lock-comment-face nil :foreground "#ca9c48")
;; (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "#ca9c48")

;; (font-lock-add-keywords 'python-mode
;; '(("\\<\\(FIXME\\):" 1 'font-lock-warning-face prepend)
;; ("\\<\\(and\\|or\\|not\\)\\>" . 'font-lock-keyword-face)))

;; font-lock-constant-face
 ;; list-faces-display

(with-eval-after-load 'latex

  ;; Jump to pdf/soure (C-c v and point and click)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
  (setq TeX-source-correlate-start-server t)
  ;; Remove sub and superscript sepcial fonting
  (setq font-latex-fontify-script nil)

  ;; Turn on RefTeX
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-auctex t)

  ;; Spell-checking
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)


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

(with-eval-after-load 'c++-mode
  ;; Install {global} at the command line first
  (autoload 'ggtags-mode "ggtags" "" t)
  (add-hook 'c++-mode-hook 
     '(lambda () 
	(ggtags-mode t)
  ))

  ;; In header files, we are still in c++-mode
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

  ;; Automatically indent when press RET
  (global-set-key (kbd "RET") 'newline-and-indent)

  ;; My c++ style
  (defun lindskou_cpp_style ()
   (setq c-default-style "bsd")
   (setq c-basic-offset 2) ;; Default is 2
   (setq c-indent-level 2) ;; Default is 2
   ;; (c-set-offset 'access-label 2)
   (c-set-offset 'substatement-open 2)
   (c-set-offset 'inlambda 0)
   (setq c++-tab-always-indent t)
  )

  (add-hook 'c++-mode-hook 'lindskou_cpp_style)


  (setq compile-command "make")
  (define-key c++-mode-map (kbd "C-c C-l") nil)
  (define-key c++-mode-map (kbd "C-c C-l") 'compile)

  (add-hook 'c++-mode-hook 
          (lambda () (define-key c++-mode-map (kbd "C-c C-l") 'compile)))
)

;; https://vxlabs.com/2018/06/08/python-language-server-with-emacs-and-lsp-mode/
 ;; https://tychoish.com/post/emacs-and-lsp-mode/
 ;; https://www.reddit.com/r/emacs/comments/m2fde6/lspmode/gqjy1mt/
 ;; https://www.mortens.dev/blog/emacs-and-the-language-server-protocol/index.html
 ;; https://www.mattduck.com/lsp-python-getting-started.html
 ;; https://github.com/emacs-lsp/lsp-python-ms/issues/26 (LINTING)
 ;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
 ;; https://emacs-lsp.github.io/lsp-ui/
 ;; Installation:
 ;; pip install python-language-server[all]
 ;; pip install ipython
 ;; pip install python-lsp-server
(with-eval-after-load 'python
  (defun my-python-hooks()
       (interactive)
       (setq
       indent-tabs-mode nil
       tab-width 4
       python-indent 4
       python-shell-interpreter "ipython"
       python-shell-interpreter-args "--simple-prompt -i"
       ;; lsp specific
       lsp-python-ms-auto-install-server t
       lsp-python-ms-executable (executable-find "python-language-server")
       lsp-diagnostics-provider :none
       lsp-headerline-breadcrumb-enable nil
       lsp-completion-enable t
       ; lsp-request-while-no-input nil
       ; lsp-completion-at-point nil
       ; lsp-completion-provider :none
       ; lsp-prefer-capf nil
       lsp-enable-snippet nil
       lsp-enable-text-document-color nil
       lsp-modeline-diagnostics-enable nil
       lsp-modeline-code-actions-enable nil
       lsp-signature-render-documentation nil
       lsp-enable-file-watchers nil
       lsp-enable-symbol-highlighting nil
       lsp-enable-on-type-formatting nil
       lsp-enable-indentation nil
       lsp-enable-folding nil
       ; lsp-ui-sideline-enable t
       ; lsp-ui-doc-delay 0.1
       ; lsp-ui-doc-include-signature t
       ; lsp-ui-doc-enable nil
       ; lsp-ui-sideline-update-mode 'line
       lsp-log-io nil
       ;; https://emacs-lsp.github.io/lsp-mode/page/keybindings/
       lsp-keymap-prefix "C-c C-l"))

  (add-hook 'python-mode-hook (lambda () (require 'lsp-python-ms) (lsp)))
  (add-hook 'python-mode-hook (lambda () (require 'lsp-ui) (lsp)))
  (add-hook 'python-mode-hook 'my-python-hooks)

  ;; ESS-like shortcut
  (add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-;") "=")))

  ;; Documentation of an object
  (define-key python-mode-map (kbd "C-c d") 'lsp-describe-thing-at-point)

  ;; Used for company completion
  (define-key python-mode-map (kbd "<backtab>") nil)

  ;; Show references for objects using M-S-?
  (define-key python-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

  ;; R-like REPL evaluation
  (require 'eval-in-repl-python)
  (setq eir-repl-placement 'right)
  (define-key python-mode-map [(shift return)] 'eir-eval-in-python)

  (defun clear-repl ()
    (interactive)
    (let ((comint-buffer-maximum-size 0))
      (comint-truncate-buffer)))
  (add-hook 'inferior-python-mode-hook (lambda () (local-set-key (kbd "C-c l") 'clear-repl)))


  (defun select-current-line ()
    (interactive)
    (end-of-line) ; move to end of line
    (set-mark (line-beginning-position)))

  (defun my-python-send-line ()
  "eval in python wont let us send lines within def blocks. Lets beat it."
    (interactive)
    (select-current-line)
    (eir-eval-in-python)
    (forward-line 1)
    (back-to-indentation))

  (define-key python-mode-map [(control return)] 'my-python-send-line)

  (make-face 'font-lock-number-face)
  (set-face-attribute 'font-lock-number-face nil :inherit font-lock-constant-face)
  (setq font-lock-number-face 'font-lock-number-face)
  (defvar font-lock-number "[0-9]+\\([eE][+-]?[0-9]*\\)?")
  (defvar font-lock-hexnumber "0[xX][0-9a-fA-F]+")
  (defun add-font-lock-numbers ()
	  (font-lock-add-keywords nil (list
			(list (concat "\\<\\(" font-lock-number "\\)\\>" )
			 0 font-lock-number-face)
			(list (concat "\\<\\(" font-lock-hexnumber "\\)\\>" )
			 0 font-lock-number-face)
			)))

 ; From the doctor (lsp-doctor)
 (setq gc-cons-threshold 200000000)
 (setq read-process-output-max (* (* 1024 1024) 3)) ;; 3mb

 ;; Some styling
 (defun highlight-todos ()
    (interactive)
    (font-lock-add-keywords nil
	  '(("\\<\\(FIXME:\\|TODO:\\|QUESTION:\\|NOTE:\\|BUG:\\)"
	     1 font-lock-warning-face t))))

 (add-hook 'prog-mode-hook (lambda ()(highlight-todos)))


 (set-face-attribute 'font-lock-builtin-face nil
 :foreground "#ffc0cb"; "#d9f989" (green)
 :weight 'bold)

)

(with-eval-after-load 'poly-markdown+r-mode
  (require 'openwith) ;; required to open pdf in external viewer
  (openwith-mode t)

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

(with-eval-after-load 'ess

  (require 'ess-r-mode)
  (define-key ess-r-mode-map [(control return)] nil)
  (define-key ess-r-mode-map [(shift return)] 'ess-eval-region-or-line-and-step)
  (define-key ess-r-mode-map [(control return)] 'ess-eval-function-or-paragraph-and-step)

  ;; Remove smart-underscore and asign <- to another key
  (add-hook 'ess-r-mode-hook (lambda () (local-set-key (kbd "C-;") "<-")))
  (add-hook 'inferior-ess-r-mode-hook (lambda () (local-set-key (kbd "C-;") "<-")))


  (add-hook 'ess-r-mode-hook (lambda () (local-set-key (kbd "C-c k") 'ess-quit)))
  (add-hook 'ess-r-mode-hook (lambda () (local-set-key (kbd "C-c l") 'ess-r-devtools-load-package)))

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
  ess-r-package-auto-set-evaluation-env nil ; C-c C-t C-s
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

;; Custom settings (e.g manually set in option pane)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; https://github.com/Malabarba/smart-mode-line
;; Keep these at the end of init!
;;(setq sml/no-confirm-load-theme t)
;;(setq sml/theme 'dark)
;; (setq sml/setup)
;; (sml/setup)

;; Open my notes at startup
;; (find-file "/home/mads/Documents/notes/README.org")
;; (setq initial-buffer-choice "README.org")
;; (kill-buffer "*scratch*")

(setq inhibit-startup-screen t)

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
