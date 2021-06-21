;; [[file:~/.emacs.d/setup_files/setup_end_of_init.org::*End%20of%20init][End of init:1]]
;; Custom settings (e.g manually set in option pane)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; https://github.com/Malabarba/smart-mode-line
;; Keep these at the end of init!
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'dark)
;; (setq sml/setup)
(sml/setup)

;; Open my notes at startup
;; (find-file "/home/mads/Documents/notes/README.org")
;; (setq initial-buffer-choice "README.org")
;; (kill-buffer "*scratch*")

(setq inhibit-startup-screen t)
;; End of init:1 ends here
