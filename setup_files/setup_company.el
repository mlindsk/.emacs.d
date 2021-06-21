;; [[file:~/.emacs.d/setup_files/setup_company.org::*Company][Company:1]]
;; https://stackoverflow.com/questions/49232454/emacs-ess-how-to-auto-complete-library-function
;; Auto-completion - install "company"
;; http://company-mode.github.io/
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Tab complete arguments inside functions (ESS)
(global-set-key (kbd "<backtab>") 'company-complete-common)
;; Company:1 ends here
