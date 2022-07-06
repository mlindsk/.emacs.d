;;; ivy-overlay.el --- Overlay display functions for Ivy  -*- lexical-binding: t -*-

;; Copyright (C) 2016-2021 Free Software Foundation, Inc.

;; Author: Oleh Krehel <ohwoeowho@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package allows to setup Ivy's completion at point to actually
;; show the candidates and the input at point, instead of in the
;; minibuffer.

;;; Code:

(eval-when-compile
  (require 'subr-x))

(defface ivy-cursor
  '((((class color) (background light))
     :background "black" :foreground "white")
    (((class color) (background dark))
     :background "white" :foreground "black"))
  "Cursor face for inline completion."
  :group 'ivy-faces)

(defvar ivy--old-cursor-type t)

(defvar ivy-overlay-at nil
  "Overlay variable for `ivy-display-function-overlay'.")

(declare-function ivy--truncate-string "ivy")

(defun ivy-left-pad (str width)
  "Return STR, but with each line indented by WIDTH spaces.
Lines are truncated to the window width."
  (let ((padding (make-string width ?\s)))
    (mapconcat (lambda (x)
                 (ivy--truncate-string (concat padding x)
                                       (1- (+ (window-width)
                                              (window-hscroll)))))
               (split-string str "\n")
               "\n")))

(defun ivy-overlay-cleanup ()
  "Clean up after `ivy-display-function-overlay'."
  (when (overlayp ivy-overlay-at)
    (delete-overlay ivy-overlay-at)
    (setq ivy-overlay-at nil))
  (unless cursor-type
    (setq cursor-type ivy--old-cursor-type))
  (when (fboundp 'company-abort)
    (company-abort)))

(defvar ivy-height)

(defun ivy-overlay-show-after (str)
  "Display STR in an overlay at point.

First, fill each line of STR with spaces to the current column.
Then attach the overlay to the character before point."
  (if ivy-overlay-at
      (progn
        (move-overlay ivy-overlay-at (1- (point)) (line-end-position))
        (overlay-put ivy-overlay-at 'invisible nil))
    (let ((available-height (- (window-height) (count-lines (window-start) (point)) 1)))
      (unless (>= available-height ivy-height)
        (recenter (- (window-height) ivy-height 2))))
    (setq ivy-overlay-at (make-overlay (1- (point)) (line-end-position)))
    ;; Specify face to avoid clashing with other overlays.
    (overlay-put ivy-overlay-at 'face 'default)
    (overlay-put ivy-overlay-at 'priority 9999))
  (overlay-put ivy-overlay-at 'display str)
  (overlay-put ivy-overlay-at 'after-string ""))

(declare-function org-current-level "org")
(declare-function org-at-heading-p "org")
(defvar org-indent-indentation-per-level)
(defvar ivy-height)
(defvar ivy-last)
(defvar ivy-text)
(defvar ivy-completion-beg)
(declare-function ivy--get-window "ivy")
(declare-function ivy-state-current "ivy")
(declare-function ivy-state-window "ivy")

(defun ivy-overlay-impossible-p (_str)
  (or
   (and (eq major-mode 'org-mode)
        (plist-get (text-properties-at (point)) 'src-block))
   (<= (window-height) (+ ivy-height 2))
   (= (point) (point-min))
   (< (- (+ (window-width) (window-hscroll)) (current-column))
      30)))

(defun ivy-display-function-overlay (str)
  "Called from the minibuffer, display STR in an overlay in Ivy window.
Hide the minibuffer contents and cursor."
  (if (save-selected-window
        (select-window (ivy-state-window ivy-last))
        (ivy-overlay-impossible-p str))
      (let ((buffer-undo-list t))
        (save-excursion
          (forward-line 1)
          (insert str)))
    (add-face-text-property (minibuffer-prompt-end) (point-max)
                            '(:foreground "white"))
    (setq cursor-type nil)
    (with-selected-window (ivy--get-window ivy-last)
      (when cursor-type
        (setq ivy--old-cursor-type cursor-type))
      (setq cursor-type nil)
      (let ((overlay-str
             (apply
              #'concat
              (buffer-substring (max (point-min) (1- (point))) (point))
              ivy-text
              (and (eolp) " ")
              (buffer-substring (point) (line-end-position))
              (and (> (length str) 0)
                   (list "\n"
                         (ivy-left-pad
                          (string-remove-prefix "\n" str)
                          (+
                           (if (and (eq major-mode 'org-mode)
                                    (bound-and-true-p org-indent-mode))
                               (if (org-at-heading-p)
                                   (1- (org-current-level))
                                 (* org-indent-indentation-per-level (or (org-current-level) 1)))
                             0)
                           (save-excursion
                             (when ivy-completion-beg
                               (goto-char ivy-completion-beg))
                             (current-column)))))))))
        (let ((cursor-offset (1+ (length ivy-text))))
          (add-face-text-property cursor-offset (1+ cursor-offset)
                                  'ivy-cursor t overlay-str))
        (ivy-overlay-show-after overlay-str)))))

(provide 'ivy-overlay)

;;; ivy-overlay.el ends here
