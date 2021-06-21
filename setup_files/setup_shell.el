;; [[file:~/.emacs.d/setup_files/setup_shell.org::*Shell][Shell:1]]
(global-set-key (kbd "C-c q")   (lambda () (interactive) (shell-command "gnome-terminal")))
(global-set-key (kbd "C-c C-q") (lambda () (interactive) (shell-command "nautilus . &")))
;; Shell:1 ends here
