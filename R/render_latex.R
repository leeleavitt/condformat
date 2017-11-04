#' Converts the table to LaTeX code
#' @param x A condformat_tbl object
#' @param ... arguments passed to knitr::kable
#' @return A character vector of the table source code
#' @export
condformat2latex <- function(x, ...) {
  finalshow <- render_show_condformat_tbl(x)
  xfiltered <- finalshow$xfiltered
  xview <- xfiltered[, finalshow$cols, drop = FALSE]
  rules <- attr(x, "condformat")$rules
  finalformat <- render_rules_condformat_tbl(rules, xfiltered, xview,
                                             format = "latex")
  # Rename the columns according to show options:
  colnames(finalformat) <- names(finalshow$cols)
  # Theme is ignored in LaTeX
  # themes <- attr(x, "condformat")$themes
  # finaltheme <- render_theme_condformat_tbl(themes, xview)
  return(knitr::kable(finalformat, format = "latex",
                      escape = FALSE, ...))
}

paste0mat <- function(x,y) {
  stopifnot(all(dim(x) == dim(y)))
  dims <- dim(x)
  out <- paste0(x, y)
  dim(out) <- dims
  return(out)
}

merge_css_conditions_to_latex <- function(css_fields, raw_text) {
  css_keys <- names(css_fields)
  output <- ""
  before <- matrix("", nrow = nrow(raw_text), ncol = ncol(raw_text))
  after <- matrix("", nrow = nrow(raw_text), ncol = ncol(raw_text))
  for (key in css_keys) {
    class(css_fields[[key]]) <- c(key, "matrix")
    stopifnot(all(dim(css_fields[[key]]) == dim(raw_text)))
    bef_after <- condformat_css_tolatex(css_fields[[key]])
    before <- paste0mat(before, bef_after$before)
    after <- paste0mat(bef_after$after, after)
  }
  output <- paste0(before, raw_text, after)
  output <- matrix(output, nrow = nrow(raw_text), ncol = ncol(raw_text))
  return(output)
}


# escape special LaTeX characters:
# from https://github.com/yihui/knitr (R/utils.R)
escape_latex = function(x, newlines = FALSE, spaces = FALSE) {
  x = gsub('\\\\', '\\\\textbackslash', x)
  x = gsub('([#$%&_{}])', '\\\\\\1', x)
  x = gsub('\\\\textbackslash', '\\\\textbackslash{}', x)
  x = gsub('~', '\\\\textasciitilde{}', x)
  x = gsub('\\^', '\\\\textasciicircum{}', x)
  if (newlines) x = gsub('(?<!\n)\n(?!\n)', '\\\\\\\\', x, perl = TRUE)
  if (spaces) x = gsub('  ', '\\\\ \\\\ ', x)
  x
}

#' How to export css values to latex
#'
#' @param css_values A character matrix with the CSS values that need to
#'                   be converted to Latex
#' @return A list with two character matrices named `before` and `after`. Both
#'         of these matrices must be of the same size as `css_values`.
#'
#' @examples
#' \dontrun{
#' # This code implements the piece needed for converting the font-weight CSS
#' # property. The before matrix contains `"\textbf leftbrace"` in the positions where a bold
#' # text is expected. In those cases the "after" matrix contains `"rightbrace"`.
#' # Therefore the final value will be paste0("\\textbf leftbrace", value, "rightbrace")
#' `condformat_css_tolatex.font-weight` <- function(css_values) {
#'   # \textbf{setosa}
#'   before <- ifelse(css_values == "bold", "\textbf{", "")
#'   after <- ifelse(css_values == "bold", "}", "")
#'   list(before=before, after=after)
#' }
#' }
#' @export
condformat_css_tolatex <- function(css_values) UseMethod("condformat_css_tolatex")

condformat_css_tolatex.default <- function(css_values) {
  css_key <- class(css_values)[1]
  warning("css key ", css_key, "not supported by condformat in LaTeX output")
  before <- matrix("", nrow = nrow(css_values), ncol = ncol(css_values))
  after <- matrix("", nrow = nrow(css_values), ncol = ncol(css_values))
  list(before = before, after = after)
}