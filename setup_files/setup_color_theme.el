;; [[file:~/.emacs.d/setup_files/setup_color_theme.org::*Theme][Theme:1]]
;; Color Theme - https://github.com/bbatsov/zenburn-emacs
(setq zenburn-override-colors-alist
'(("zenburn-yellow" . "#8FD878")
("zenburn-cyan"     . "#F0D278")))

(load-theme 'zenburn t)
;; Theme:1 ends here

;; [[file:~/.emacs.d/setup_files/setup_color_theme.org::*Theme][Theme:2]]
;; (setq mads/themes '(dracula zenburn doom-nord-light doom-solarized-dark doom-solarized-light))
(setq mads/themes '(
zenburn  
;; apropospriate-light  
doom-nord-light
doom-solarized-light
;; apropospriate-dark
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
;; Theme:2 ends here

;; [[file:~/.emacs.d/setup_files/setup_color_theme.org::*Zenburn%20colors][Zenburn colors:1]]
;;   ("zenburn-fg-1"     . "#656555")
;;   ("zenburn-fg-05"    . "#989890")
;;   ("zenburn-fg"       . "#DCDCCC")
;;   ("zenburn-fg+1"     . "#FFFFEF")
;;   ("zenburn-fg+2"     . "#FFFFFD")
;;   ("zenburn-bg-2"     . "#000000")
;;   ("zenburn-bg-1"     . "#2B2B2B")
;;   ("zenburn-bg-08"    . "#303030")
;;   ("zenburn-bg-05"    . "#383838")
;;   ("zenburn-bg"       . "#3F3F3F")
;;   ("zenburn-bg+05"    . "#494949")
;;   ("zenburn-bg+1"     . "#4F4F4F")
;;   ("zenburn-bg+2"     . "#5F5F5F")
;;   ("zenburn-bg+3"     . "#6F6F6F")
;;   ("zenburn-red-6"    . "#6C3333")
;;   ("zenburn-red-5"    . "#7C4343")
;;   ("zenburn-red-4"    . "#8C5353")
;;   ("zenburn-red-3"    . "#9C6363")
;;   ("zenburn-red-2"    . "#AC7373")
;;   ("zenburn-red-1"    . "#BC8383")
;;   ("zenburn-red"      . "#CC9393")
;;   ("zenburn-red+1"    . "#DCA3A3")
;;   ("zenburn-red+2"    . "#ECB3B3")
;;   ("zenburn-orange"   . "#DFAF8F")
;;   ("zenburn-yellow-2" . "#D0BF8F")
;;   ("zenburn-yellow-1" . "#E0CF9F")
;;   ("zenburn-yellow"   . "#F0DFAF")
;;   ("zenburn-green-5"  . "#2F4F2F")
;;   ("zenburn-green-4"  . "#3F5F3F")
;;   ("zenburn-green-3"  . "#4F6F4F")
;;   ("zenburn-green-2"  . "#5F7F5F")
;;   ("zenburn-green-1"  . "#6F8F6F")
;;   ("zenburn-green"    . "#7F9F7F")
;;   ("zenburn-green+1"  . "#8FB28F")
;;   ("zenburn-green+2"  . "#9FC59F")
;;   ("zenburn-green+3"  . "#AFD8AF")
;;   ("zenburn-green+4"  . "#BFEBBF")
;;   ("zenburn-cyan"     . "#93E0E3")
;;   ("zenburn-blue+3"   . "#BDE0F3")
;;   ("zenburn-blue+2"   . "#ACE0E3")
;;   ("zenburn-blue+1"   . "#94BFF3")
;;   ("zenburn-blue"     . "#8CD0D3")
;;   ("zenburn-blue-1"   . "#7CB8BB")
;;   ("zenburn-blue-2"   . "#6CA0A3")
;;   ("zenburn-blue-3"   . "#5C888B")
;;   ("zenburn-blue-4"   . "#4C7073")
;;   ("zenburn-blue-5"   . "#366060")
;;   ("zenburn-magenta"  . "#DC8CC3")
;; Zenburn colors:1 ends here