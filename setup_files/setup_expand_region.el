;; [[file:~/.emacs.d/setup_files/setup_expand_region.org::*Expand%20Region][Expand Region:1]]
;; Annoying redefinition warning
(setq ad-redefinition-action 'accept)
(require 'expand-region)
(global-set-key (kbd "C-(") 'er/expand-region)
(global-set-key (kbd "C-)") 'er/mark-outside-pairs)
;; Expand Region:1 ends here
