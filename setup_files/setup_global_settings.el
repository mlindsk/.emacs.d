;; [[file:~/.emacs.d/setup_files/setup_global_settings.org::*Global%20Settings][Global Settings:1]]
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

 ;; Remote stuff
 (setq tramp-default-method "ssh")
 ;; https://www.dcalacci.net/2018/remote-ess/
 ;; https://www.r-bloggers.com/run-a-remote-r-session-in-emacs-emacs-ess-r-ssh/

 ;; Stop using emacs internal viewer
 (require 'openwith)
 (openwith-mode t)
 (setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

 ;; https://emacs.stackexchange.com/questions/5553/
 ;; async-shell-process-buffer-always-clobbers-window-arrangement
 ;; (Calling external programs with M-! makes a lot of unwanted results) 
 (add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

 (global-set-key (kbd "C-x k") 'kill-this-buffer) ;; Kill this buffer - instead of selecting.
 (fset 'yes-or-no-p 'y-or-n-p)                    ;; Avoid typing yes and no
 (set-cursor-color "#ffffff") 
 (require 'smooth-scrolling)
 (smooth-scrolling-mode 1)
 (setq smooth-scroll-margin 5)
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

 (global-set-key (kbd "C-,") 'point-to-register) ;; jumpt to buffer position using registers
 (global-set-key (kbd "C-.") 'jump-to-register)

;;  ;; set transparency
;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha)))
;;               100)
;;          '(90 . 90) '(100 . 100)))))
;; (global-set-key (kbd "C-c t") 'toggle-transparency)
;; Global Settings:1 ends here

;; [[file:~/.emacs.d/setup_files/setup_global_settings.org::*Global%20Settings][Global Settings:2]]
;;(set-fringe-mode 10)
;; Global Settings:2 ends here
