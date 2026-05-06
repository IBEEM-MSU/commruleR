#' test_collaboratR_gdrive.R


test_new_id <- 1943

test_url <- Sys.getenv('TEST_URL') # "https://docs.google.com/spreadsheets/d/1-eMIuFa0d8MyUOzwnJ6nffa4wa4ImDwut6Z5SIqOIPk/edit?gid=0#gid=0"

test_that("tests work", {
  expect_true(TRUE)
})


test_that("can setup auth to google drive", {
  result = gdrive_setup()
  google_auth_for_testing()
  expect_true(result)
})

test_that("can get gs file spec from url", {
  result <- get_gsfile(file_name_or_url=test_url)
  expect_true(!is.null(result))
  # todo: use regex test, which I can find that returns the whole string
  expect_type(googledrive::as_id(result), "character")

  # check that the google drive id is just alpha number using str_extract output having same length as id
  file_id = googledrive::as_id(result)
  expect_equal(nchar(file_id), 44)
})

test_that("can get gs file spec", {
  test_drive_path <- 'CommAssemblyRULES'
  test_drive_file <-'Year Mapping'
  shared_drive = Sys.getenv('PROJECT_SHARE_DRIVE')
  result <- get_gsfile(file_name_or_url=test_drive_file, shared_drive=shared_drive, drive_path=test_drive_path)
  expect_true(!is.null(result))
  # todo: use regex test, which I can find that returns the whole string
  expect_type(googledrive::as_id(result), "character")

  # check that the google drive id is just alpha number using str_extract output having same length as id
  file_id = googledrive::as_id(result)
  rematch <- stringr::str_extract( file_id, stringr::regex('[a-zA-Z0-9\\-]*'))
  expect_equal(nchar(file_id), nchar(rematch))
})

test_that("can download_csv_file", {
  test_drive_path <- 'CommAssemblyRULES'
  test_drive_file <- 'Year Mapping'
  shared_drive = Sys.getenv('PROJECT_SHARE_DRIVE')
  result <-read_gcsv(file_name_or_url =test_drive_file, shared_drive=shared_drive, drive_path=test_drive_path)
  expect_true(!is.null(result))
})

