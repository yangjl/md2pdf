#' \code{Markdown to pdf}
#'
#' Generate customized (templated based) pdf from md.
#'
#' @param template Tex template files.
#' @param outbase Output file.
#' @param mds Markdown files.
#' @param shfile shell script to build (running system in R console could cause problem).
#' @param clean Clean up the mess.
#'
#' @return return latex and pdf files.
#'
#' @examples
#' setwd("test")
#' md2pdf(template="apa6template.tex", outbase="outfile", mds="source/*.md")
#'
#' @export
md2pdf <- function(template="templates/apa6template.tex", outbase="test/outfile",
                   mds="test/source/*.md", shfile="run.sh", clean=TRUE){

  pcmd1 <- paste0("pandoc -N -f markdown+tex_math_double_backslash ",
                '--template=', template, " ", mds,
                ' -s -S -o ', outbase, ".tex")
  pcmd2 <- paste0("pdflatex ", outbase, ".tex")
  pcmd3 <- paste0("biber ", outbase)

  mess <- paste("rm *.bbl *.bcf *.blg *.log *.run.xml;",
                "rm *.ttt *.fls *.fdb_latexmk *.dvi *.out")
  ### generate pdf file
  cat("#!/bin/bash",
      pcmd1,
      pcmd2,
      pcmd3,
      pcmd2,
      pcmd3,
      pcmd2,
      file=shfile, sep="\n")
  ### clean up the mess
  if(clean){
    cat(mess, file=shfile, sep="\n", append=TRUE)
  }

  message(sprintf("###>>> in [ %s ], run [ sh %s ]", getwd(), shfile))

}


