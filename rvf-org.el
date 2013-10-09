(require 'org-protocol)

(require 'ob-latex)

(require 'ox-latex)
(require 'ox-md)

(add-to-list 'org-latex-classes
             '("beamer" "\\documentclass[presentation]{beamer}
\[DEFAULT-PACKAGES]
\[PACKAGES]
\[EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(add-to-list 'org-latex-packages-alist '("" "listings"))

(add-hook 'org-mode-hook 'turn-on-auto-revert-mode)

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(add-hook 'org-mode-hook 'smartparens-mode)

;; from the info documentation
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (yas/minor-mode-on)
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(setq org-hide-emphasis-markers t)
(setq org-latex-listings t)
(setq org-latex-pdf-process '("texi2dvi -p -b -V %f"))
(setq org-log-done 'note)
(setq org-return-follows-link t)
(setq org-src-fontify-natively t)
(setq org-support-shift-select 'always)

(setq org-tag-faces '(
                      ("LIMA" . (:foreground "green" :weight bold :underline t))
                      ("titulacion" . (:foreground "blue" :weight bold :underline t))
                      ("todo" . (:foreground "orange" :weight bold :underline t))
                      ))

; the space at the beginning is useful to move the cursor
(setq org-agenda-prefix-format 
      '((agenda . " %i %-12:c%?-12t% s")
	(timeline . "  % s")
	(todo . " %-12:c")
	(tags . " %-12:c")
	(search . " %-12:c")))

(setq org-agenda-entry-text-leaders "    ")
(setq org-agenda-category-icon-alist
      '(
        ("Tasks" "/usr/share/icons/Humanity/stock/16/stock_task.svg" nil nil :ascent center)
        ("LIMA" "/usr/share/icons/Humanity/actions/16/add.svg" nil nil :ascent center)
        ("Math" "/usr/share/icons/gnome/16x16/apps/libreoffice-math.png" nil nil :ascent center)
        ("Saint" "/usr/share/icons/gnome/16x16/emotes/face-angel.png" nil nil :ascent center)
        ("Emacs" "/usr/share/emacs/24.3/etc/images/icons/hicolor/16x16/apps/emacs.png" nil nil :ascent center)
        ))

(setq org-file-apps
      '((auto-mode . emacs)
	("pdf" . "evince %s")
	("djvu" . "evince %s")
	("html" . "firefox %s")
	))

(load "~/.emacs.d/rvf-captures.el")