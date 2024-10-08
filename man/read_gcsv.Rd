% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gdrive.R
\name{read_gcsv}
\alias{read_gcsv}
\title{download a CSV file from the project google shared drive and read into memory}
\usage{
read_gcsv(
  file_name_or_url,
  shared_drive = NULL,
  drive_path = NULL,
  has_comment_line = TRUE
)
}
\arguments{
\item{shared_drive}{name of the shared drive to look in, default NULL passed to get_gsfile which which reads path from environment (see get_gsfile)}

\item{drive_path}{common project path to use, optional, passed to get_gsfile which reads from environment (see get_gsfile)}

\item{has_comment_line}{=TRUE, does the google sheet have comments/directions on line 2 that needs to be stripped}

\item{filepath}{full name of the CSV file (e.g. myfile.csv ) with optional partial path.}
}
\value{
a data.frame as returned by read.csv, no row names.
}
\description{
NOTE this can import gsheet as CSV, but only the first tab.  Use read_gsheet_by_url() for multi-tab sheets
Reads either CSV file or gsheet doc from a shared drive and reads it in as data frame.  If there are multiple files
found with the same name on the share drive, throws a warning and reads only the first one
it finds  (which may not be the most recent one!   )
This is not needed for working with folders/datafiles connected to your computer
via Google Drive Desktop (Mac/Windows), only for reading files directly the Internet via URL.  Requires access
to a share drive
}
