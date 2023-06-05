# APT packages for building vignettes and reference manuals

# texlive
# texlive-font-utils          # for epstopdf
# texlive-pstricks            # provides pstricks.sty
# texlive-latex-extra         # provides fullpage.sty
# texlive-fonts-extra         # provides incosolata.sty
# texlive-bibtex-extra        # provides unsrturl.bst
# texlive-science             # provides algorithm.sty
# texlive-luatex              # provides luatex85.sty
# texlive-lang-european       # provides language definition files e.g. swedish.ldf
# texi2html
# texinfo
# pandoc                      # needed for CRAN package knitr
# pandoc-citeproc             # needed for CRAN package knitr
# biber
    #ttf-mscorefonts-installer


dnf install -y texlive texlive-pstricks texlive-luatex texi2html texinfo 