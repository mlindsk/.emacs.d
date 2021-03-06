;;; eval-in-repl-lua.el --- ESS-like eval for lua  -*- lexical-binding: t; -*-

;; Copyright (C) 2017 Theldoria

;; Author: Theldoria <theldoria@hotmail.com>
;; Keywords: tools, convenience
;; Version: 0.1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; lua-mode.el-specific file for eval-in-repl


;;; Code:

;;;
;;; Require dependencies
(require 'eval-in-repl)
(require 'lua-mode)

(defun eval-in-repl-run-lua ()
  (or (and (comint-check-proc lua-process-buffer)
           lua-process)
      (lua-start-process))
  (switch-to-buffer-other-window lua-process-buffer))

;;;
;;; LUA-MODE RELATED
;;; eir-send-to-lua
(defalias 'eir-send-to-lua
  (apply-partially 'eir-send-to-repl
                   ;; fun-change-to-repl
                   #'eval-in-repl-run-lua
                   ;; fun-execute
                   #'comint-send-input)
  "Send expression to *lua* and have it evaluated.")


;;; eir-eval-in-lua
;; http://www.reddit.com/r/emacs/comments/1h4hyw/selecting_regions_luael/
;;;###autoload
(defun eir-eval-in-lua ()
  "eval-in-repl for Lua."
  (interactive)
  ;; Define local variables
  (let* (;; Save current point
         (initial-point (point)))
    ;;
    (eir-repl-start "\\*lua\\*" #'run-lua t)

    ;; Check if selection is present
    (if (and transient-mark-mode mark-active)
        ;; If selected, send region
        (eir-send-to-lua (buffer-substring-no-properties (point) (mark)))

      ;; If not selected, do all the following
      ;; Move to the beginning of line
      (beginning-of-line)
      ;; Set mark at current position
      (set-mark (point))
      ;; Go to the end of line
      (end-of-line)
      ;; Send region if not empty
      (if (not (equal (point) (mark)))
          (eir-send-to-lua (buffer-substring-no-properties (point) (mark)))
        ;; If empty, deselect region
        (setq mark-active nil))

      ;; Move to the next statement code if jumping
      (if eir-jump-after-eval
          (eir-next-code-line)
        ;; Go back to the initial position otherwise
        (goto-char initial-point)))))


(provide 'eval-in-repl-lua)
;;; eval-in-repl-lua.el ends here

