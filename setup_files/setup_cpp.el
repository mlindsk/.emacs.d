;; [[file:~/.emacs.d/setup_files/setup_cpp.org::*C++][C++:1]]
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
;; C++:1 ends here
