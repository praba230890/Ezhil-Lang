;;Copyright (C) 2008-2013 Muthiah Annamalai
;;parts of code inspired by GNU Emacs file octave-mod.el

;; Copyright (C) 1997, 2001, 2002, 2003, 2004, 2005, 2006, 2007
;; Free Software Foundation, Inc.

;; Author: Kurt Hornik <Kurt.Hornik@wu-wien.ac.at>
;; Author: John Eaton <jwe@bevo.che.wisc.edu>
;; Maintainer: Kurt Hornik <Kurt.Hornik@wu-wien.ac.at>
;; Keywords: languages

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; Syntax highlighting for Ezhil programming language; http://ezhillang.org/
;; (C) 2013, Muthiah Annamalai

(setq ezhil-keywords '("ஆனால்" "ஏதேனில்" "தேர்வு" "பதிப்பி" "தேர்ந்தெடு" "இல்லைஆனால்" "ஆக" "இல்லை" "வரை" "செய்" "பின்கொடு" "முடியேனில்" "முடி" "நிரல்பாகம்" "தொடர்" "நிறுத்து" "இல்" "ஒவ்வொன்றாக"))

(defvar ezhil-begin-keywords
  '( "ஆக"  "ஒவ்வொன்றாக" "ஆனால்" "வரை" "செய்" ))

(defvar ezhil-else-keywords
  '("ஏதேனில்" "தேர்வு" "இல்லைஆனால்" "இல்லை"))

(defvar ezhil-end-keywords
  '("முடி" "முடியேனில்"))

(setq ezhil-types '("float" "int" "string"))
(setq ezhil-constants '("None" "True" "False"))
(setq ezhil-events '())
(setq ezhil-functions '("abs" "acos" "len" "assert" "seed" "exit" "randint" "choice" "random"))

;; create the regex string for each class of keywords
(setq ezhil-keywords-regexp (regexp-opt ezhil-keywords 'words))
(setq ezhil-type-regexp (regexp-opt ezhil-types 'words))
(setq ezhil-constant-regexp (regexp-opt ezhil-constants 'words))
(setq ezhil-event-regexp (regexp-opt ezhil-events 'words))
(setq ezhil-functions-regexp (regexp-opt ezhil-functions 'words))

;; clear memory
(setq ezhil-keywords nil)
(setq ezhil-types nil)
(setq ezhil-constants nil)
(setq ezhil-events nil)
(setq ezhil-functions nil)

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq ezhil-font-lock-keywords
  `(
    (,ezhil-type-regexp . font-lock-type-face)
    (,ezhil-constant-regexp . font-lock-constant-face) 
    (,ezhil-event-regexp . font-lock-builtin-face)
    (,ezhil-functions-regexp . font-lock-function-name-face)
    (,ezhil-keywords-regexp . font-lock-keyword-face)
    ;; note: order above matters. “ezhil-keywords-regexp” goes last because
    ;; otherwise the keyword “state” in the function “state_entry”
    ;; would be highlighted.
))


(defvar comment-char ?#
  "Character to start an Ezhil comment.")

(defvar ezhil-comment-char ?#
  "Character to start an Ezhil comment.")

;;; Comments
(defun ezhil-comment-region (beg end &optional arg)
  "Comment or uncomment each line in the region as Ezhil code.
See `comment-region'."
  (interactive "r\nP")
  (let ((comment-start (char-to-string ezhil-comment-char)))
    (comment-region beg end arg)))

;; syntax table
(defvar ezhil-syntax-table nil "Syntax table for `ezhil-mode'.")
(setq ezhil-syntax-table
      (let ((synTable (make-syntax-table)))

        ;; bash style comment: “# …” 
        (modify-syntax-entry ?# "< b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)

        synTable))

;; define the mode
(define-derived-mode ezhil-mode fundamental-mode
  "ezhil-lang mode"
  "Major mode for editing ezhil (Ezhil-Lang : Write imperative programs in Indian language Tamil …"
  :syntax-table ezhil-syntax-table
  
  ;; code for syntax highlighting
  (setq font-lock-defaults '((ezhil-font-lock-keywords)))

  ;; clear memory
  (setq ezhil-keywords-regexp nil)
  (setq ezhil-types-regexp nil)
  (setq ezhil-constants-regexp nil)
  (setq ezhil-events-regexp nil)
  (setq ezhil-functions-regexp nil)
)

(add-to-list 'auto-mode-alist '("\\.n\\'" . ezhil-mode))
(provide 'ezhil-mode)
