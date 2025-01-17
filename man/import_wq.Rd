% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import_wq.R
\name{import_wq}
\alias{import_wq}
\title{Importing water quality data from the EA Water Quality Archive database}
\usage{
import_wq(source = NULL,
          sites,
          dets = "default",
          start_date = "2020-01-01",
          end_date = Sys.Date(),
          save = TRUE)
}
\arguments{
\item{source}{Either NULL, indicating the data should be downloaded from WIMS; or a path specifying a csv file with the same columns as would be in the downloaded file. Default = NULL.}

\item{sites}{A list containing WQ sites for which data is to be imported.}

\item{dets}{Sets the list of determinants to be imported. If “default”, a specific list of determinands will be imported (see details). If “all” is specified, all determinants are imported. Alternatively, a vector of determinand codes (specified as integers) can be supplied. Default = “default”.}

\item{start_date}{The date of the first record to be imported. Default = "2020-01-01"}

\item{end_date}{The date of the last record to be imported. If a date in the future is specified, end_date will be replaced with Sys.Date(). Default Sys.Date()}

\item{save}{A logical value confirming whether or not to save a copy of the filtered import file to the current working directory. Default = TRUE.}
}
\value{
A tibble containing the imported water quality data. The data are arranged in long format, with the following columns:
\itemize{
\item wq_site_id (unique WQ site id)
\item date (of WQ record)
\item det_label (details of which determinant is measured in the record)
\item det_id (ID number of the determinand, returned as integers)
\item result (measured value of determinand)
\item unit (the unit of measurement for the determinand)
\item qualifier (character value “<” indicating whether the result is below the limit of quantification for the relevant determinant). Will be NA if the true measurement has been returned.
}
}
\description{
The \code{import_wq} function imports water quality (WQ) data from the Environment Agency’s Water Quality Archive database. The data can either be downloaded automatically in .csv format or read in from a previously saved .csv or .rds file. The data can be optionally filtered by WQ site ID, determinand and/or sample date, and the filtered data saved as a .rds file.
}
\details{
The Water Quality Archive only has data since 2000. Data from 1999 and before is not available using this function.

The default list of determinands to import (specified using dets = “default”) is: pH, temperature, conductivity at 25C, ammoniacal nitrogen as N, nitrogen total oxidised as N, nitrate as N, nitrite as N, ammonia un-ionised as N, alkalinity to Ph 4.5 as CaCO3, orthophosphate reactive as P, oxygen \% dissolved saturation, oxygen dissolved as O2, chlorophyll, and suspended solids, and turbidity (6396). These are coded as determinand IDs: 61, 76, 77, 111, 116, 117, 118, 119, 162, 180, 9901, 9924, 19, 135, 6396.

There are over 7000 determinands in the Water Quality Archive. To download a complete list in .csv format see https://environment.data.gov.uk/water-quality/def.csv/determinands. See also https://environment.data.gov.uk/water-quality/view/doc/reference#api-determinands for alternative ways to find determinands.

If supplying a list of determinand IDs to the function, these may be specified as integers (ie, no leading zeros) or 4-digit character strings (ie, numbers enclosed in quotes, eg: c("0061", "9901")). Note that det_id in the output file is a numeric variable.

If saving a copy of the downloaded data, the name of the rds file is hard-wired to WQ_OPEN_DATA_METRICS.RDS. The file will save to the current working directory.

Downloaded raw data files will be automatically removed from the working directory following completed execution of the function.

The function automatically modifies the downloaded data by updating the column names, fixing the formats of the data as required and selecting only the required columns. There is no processing of the data.

Note that the WQ site IDs used in WIMS do not match the biol_site_id or flow_site_ids used in other functions in this package. For use in the wider HE Toolkit workflow, links must be made between wq_site_id in the returned file and at least one of biol_site_id or flow_site_id.
}
\examples{
# Bulk download of data for a single site and save as .rds file for future use:
temp <- import_wq(sites = "SW-60250424")

# Import previously downloaded data in .csv format:
\dontrun{
temp <-import_wq(source = "data/example_import_wq.csv", sites = "SW-60250424", save = FALSE)
}
}
