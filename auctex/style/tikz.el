(TeX-add-style-hook "tikz"
  (function
   (lambda ()
     (TeX-PDF-mode-on)
     (TeX-add-symbols
     '("draw")
     '("foreach")
     '("pgfmathsetmacro" 2)
     '("tikzset" 1)
     '("usetikzlibrary" 1)
     )
     (LaTeX-add-environments
      '("scope")
      '("tikzpicture")
      )
     )
   )
  )
