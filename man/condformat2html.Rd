% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_html.R
\name{condformat2html}
\alias{condformat2html}
\title{Converts the table to a htmlTable object}
\usage{
condformat2html(x)
}
\arguments{
\item{x}{A condformat_tbl object}
}
\value{
the htmlTable object
}
\description{
Converts the table to a htmlTable object
}
\examples{
data(iris)
condformat2html(condformat(iris[1:5,]))
}
