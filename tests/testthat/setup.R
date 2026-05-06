test_biomass_url<- 'https://docs.google.com/spreadsheets/d/1JVTRm1uQCrcOjXCULBYEgbW5oyd1S7SVGq6D1JpwCW4/edit?gid=0#gid=0'

## read auth from environment here in addition to modules
PROJECT_EMAIL=Sys.getenv("PROJECT_EMAIL")
PROJECT_API_KEY=Sys.getenv("PROJECT_API_KEY")
DRIVE_API_ID_FILE=Sys.getenv("DRIVE_API_ID_FILE")
DRIVE_API_ID_NAME=Sys.getenv("DRIVE_API_ID_NAME")
PROJECT_SHARE_DRIVE=Sys.getenv("PROJECT_SHARE_DRIVE")
PROJECT_SHARE_DRIVE_PATH=Sys.getenv("PROJECT_SHARE_DRIVE_PATH") 
TEST_URL=Sys.getenv("TEST_URL") 
TEST_ID_LIST_URL=Sys.getenv("TEST_ID_LIST_URL") 
TEST_TEMPLATE_URL=Sys.getenv("TEST_TEMPLATE_URL") 

# Check for essential variables and stop/warn if missing
if (PROJECT_EMAIL == "") {
  stop("Environment variable PROJECT_EMAIL is missing. Authentication will fail in non-interactive sessions.")
}

if (DRIVE_API_ID_FILE == "") {
  warning("Environment variable DRIVE_API_ID_FILE is missing.")
} else if (!file.exists(DRIVE_API_ID_FILE)) {
  stop(paste("DRIVE_API_ID_FILE not found at:", DRIVE_API_ID_FILE))
}

# Setup Non-interactive Authentication
# Following gargle's "Non-interactive auth" vignette
library(googledrive)
library(googlesheets4)

# Prevent interactive prompts
options(gargle_interactivity = FALSE)

# De-authorize existing credentials to start fresh
googledrive::drive_deauth()
googlesheets4::gs4_deauth()

# Configure the Google Drive and Sheets clients if the ID file is provided
if (DRIVE_API_ID_FILE != "" && file.exists(DRIVE_API_ID_FILE)) {
  google_client <- gargle::gargle_oauth_client_from_json(
    path = DRIVE_API_ID_FILE,
    name = DRIVE_API_ID_NAME
  )
  googledrive::drive_auth_configure(client = google_client)
  googlesheets4::gs4_auth_configure(client = google_client)
}

# Authenticate with the provided email.
# This relies on a cached token previously obtained in an interactive session.
tryCatch({
  googledrive::drive_auth(
    email = PROJECT_EMAIL, 
    scopes = "https://www.googleapis.com/auth/drive.readonly"
  )
  # Share the token with googlesheets4
  googlesheets4::gs4_auth(token = googledrive::drive_token())
}, error = function(e) {
  stop("Failed to authenticate non-interactively. Ensure you have logged in once interactively with: \ngdrive_setup(drive_email = '", PROJECT_EMAIL, "')\nOriginal error: ", e$message)
})

google_auth_for_testing = function(drive_api_id_file = DRIVE_API_ID_FILE, drive_api_id_name=DRIVE_API_ID_NAME ) {
  # This function is now mostly a wrapper around the authentication already performed in setup.R
  # If tokens are lost for some reason, try to re-auth
  if (!googledrive::drive_has_token()) {
    googledrive::drive_auth(email = PROJECT_EMAIL, scopes = "https://www.googleapis.com/auth/drive.readonly")
  }
  if (!googlesheets4::gs4_has_token()) {
    googlesheets4::gs4_auth(token = googledrive::drive_token())
  }
  return(TRUE)
}

