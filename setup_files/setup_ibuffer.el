;; [[file:~/.emacs.d/setup_files/setup_ibuffer.org::*Ibuffer][Ibuffer:1]]
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
;; Ibuffer:1 ends here