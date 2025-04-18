% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database.R
\name{read_data_csv}
\alias{read_data_csv}
\title{read in a CSV from L0 folder, using specification spec}
\usage{
read_data_csv(csv_file_path, spec.df = NULL)
}
\arguments{
\item{csv_file_path}{character path to csv file}

\item{spec.df}{optional data frame list of data specifications}
}
\value{
data.frame, or NA if the file is not found or if there are validation issues
}
\description{
reading in a CSV using readr package, but ensure the data still matches
a specification
}
