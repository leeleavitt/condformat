% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_gtable.R
\name{cf_field_to_gtable}
\alias{cf_field_to_gtable}
\title{How to export a cf_field to grob}
\usage{
cf_field_to_gtable(cf_field, xview, gridobj, unlocked, has_rownames,
  has_colnames)
}
\arguments{
\item{cf_field}{A cf_field object. This is like a rule, but with the computed
colour values. It usually maps one-to-one to a CSS field.}

\item{xview}{A data frame with the columns to be printed and rows filtered}

\item{gridobj}{The tableGrob object}

\item{unlocked}{A logical matrix of cells unlocked (that can still be modified by further
rules).}

\item{has_rownames}{Whether or not the gridobj has a first column with row names}

\item{has_colnames}{Whether or not the gridobj has a first row with column names}
}
\value{
A list with two elements: gridobj and unlocked (with updated values)
}
\description{
This method is exported so package users can generate their own rules
}
