
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/rvf-elpa.el")

(push "~/.emacs.d/site-lisp/gnus/lisp" load-path)

(if (file-exists-p "~/.emacs.d/custom.el")
    (load "~/.emacs.d/custom.el"))

;; From http://www.emacswiki.org/emacs/LoadPath#AddSubDirectories
;; to add a directory and its subdirectories

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; Shadow
           (append 
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/.emacs.d/site-lisp/org-mode/doc")))

(defun make-backup-file-name (file-name)
  "Create the non-numeric backup file name for `file-name'."
  (require 'dired)
  (if (file-exists-p "~/backups")
      (concat (expand-file-name "~/backups/")
              (dired-replace-in-string "/" "-" file-name))
    (concat file-name "~")))

;; emacs-lisp

(define-key emacs-lisp-mode-map [(tab)] 'completion-at-point)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

;; bibretrieve
(require 'bibretrieve)
(setq bibretrieve-backends ' (("mrl" . 10)))

;; cdlatex: http://staff.science.uva.nl/~dominik/Tools/cdlatex/

(setq cdlatex-math-symbol-alist
   '(
     ( ?c  ("\\colon"))
     ( ?m  ("\\mu" "\\mapsto"))
     ( ?p  ("\\pi" "\\varpi" "\\perp"))
     ( ?O  ("\\Omega" "\\mathrm{Orb}"))
     ( ?S  ("\\Sigma" "\\mathrm{Stab}"))
     ( ?-  ("\\cap" "\\leftrightarrow" "\\longleftrightarrow" ))
     ( ?.  ("\\ldots" "\\cdots" "\\cdot" ))
     ( ?<  ("\\leq" "\\langle"))
     ( ?>  ("\\geq" "\\rangle"))
     ( 123  ("\\{ \\}" ))
     ( 125  ("\\subseteq" ))
     ( ?\[  ("\\subseteq" ))
     )
   )

(setq cdlatex-math-modify-alist
      '(
	( ?B    "\\mathbb"           nil        t   nil nil )
	)
      )

(setq cdlatex-command-alist
      '(
	("bin"         "Insert \\binom{}{}"
	 "\\binom{?}{}"           cdlatex-position-cursor nil nil t)
	("norm"         "Insert \\Vert \\Vert"
	 "\\Vert ?\\Vert"           cdlatex-position-cursor nil nil t)
	("gen"         "Insert \\langle \\rangle"
	 "\\langle ?\\rangle"           cdlatex-position-cursor nil nil t)
	("set"         "Insert a set"
	 "\\{?\\mid \\}"           cdlatex-position-cursor nil nil t)
	))

(setq cdlatex-simplify-sub-super-scripts nil)

;; yasnippet: https://github.com/capitaomorte/yasnippet

(require 'yasnippet) 
(yas--load-snippet-dirs)
;; otherwise some lines are indented after expansion of a snippet
(setq yas/indent-line 'fixed)

;; octopress
(require 'octopress)

;; smart-mode-line: https://github.com/Bruce-Connor/smart-mode-line

(setq sml/theme 'dark)
(require 'smart-mode-line)
(sml/setup)

;; smartparens: https://github.com/Fuco1/smartparens
(require 'smartparens)
(sp-with-modes '(
                 org-mode
                 )
  (sp-local-pair "`" nil :actions nil)
  (sp-local-pair "'" nil :actions nil)
  (sp-local-pair "\\{" "\\}")
  (sp-local-pair "\\[" "\\]")
  )
(sp-with-modes '(
		 emacs-lisp-mode
                 )
  (sp-local-pair "'" nil :actions nil)
  )
(show-smartparens-global-mode +1)

;; smex: https://github.com/nonsequitur/smex/

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(load "~/.emacs.d/rvf-settings.el")

;; this is needed since LaTeX-mode has not been loaded (being an ELPA package)
(add-hook 'LaTeX-mode-hook (lambda () (load "~/.emacs.d/rvf-latex.el")))

(load "~/.emacs.d/rvf-org.el")
(load "~/.emacs.d/rvf-kramdown.el")
(load "~/.emacs.d/rvf-jekyll.el")

(require 'calfw)
(require 'calfw-org) 
(require 'cal-catholic)
(require 'cal-benedictine)
(require 'cal-dominican)
(require 'cal-franciscan)
(require 'cal-sanctoral-updates)
(add-hook 'diary-display-hook 'fancy-diary-display)
(setq diary-list-include-blanks t)

(load "~/.emacs.d/rvf-misc.el")

(load "~/.emacs.d/rvf-dired.el")

(load "~/.emacs.d/rvf-key-bindings.el")

(load "~/.emacs.d/rvf-cosmetic.el")

(load "~/.emacs.d/rvf-appts.el")

(load "~/.emacs.d/rvf-refs.el")

(load "~/.emacs.d/rvf-programming.el")

(if (or (equal system-name "lahp") (equal system-name "dell"))
    (load "~/.emacs.d/rvf-personal.el")
  )

(require 'chess)
(setq chess-images-directory (concat "~/.emacs.d/elpa/chess-" chess-version "/pieces/xboard"))
(setq chess-images-separate-frame nil)
(setq chess-images-default-size 33)
;; Next row is needed for C-c C-c in pgn files to display position
(load-library "chess-file")

(pdf-tools-install)

(diary)

(if (equal system-name "lahp")
    (display-battery-mode)
  )


