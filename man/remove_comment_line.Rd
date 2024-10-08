% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gdrive.R
\name{remove_comment_line}
\alias{remove_comment_line}
\title{remove line 2 from a csv file, used by data-entry for column directions/description.}
\usage{
remove_comment_line(local_file_path, line_numbers = 2, new_file_path = NULL)
}
\arguments{
\item{local_file_path}{path to text file on your disk, relative or absolute}

\item{line_numbers}{default 2, 1 number or a vector, range of numbers to exclude (2:5)}

\item{new_file_path}{optional new name to write to, by default will use the local_file_path and overwrite}
}
\description{
this will read all lines of a test file (which can take a long time/memory for a long file),
remove some of the lines by number and write those to disk.   If no new_file_path param
is sent, will overwrite the original file which will be lost
it will write a file with standard POSIX (linux/mac) line endings for now
}
