# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

# Simple working version

# get_brand <- function(brand_yml) {
#   rlang::check_installed(
#     "bslib",
#     "bslib is required for brand support in R",
#     version = "0.9.0"
#   )
#   brand <<- attr(bslib::bs_theme(brand = brand_yml), "brand")
#   brand_colors <<- brand$color$palette
# }

# Auto search for brand version
get_brand <- function(root_dir = ".", brand_filename = "brand.yml") {
  # Check dependencies
  rlang::check_installed(
    "bslib",
    "bslib is required for brand support in R",
    version = "0.9.0"
  )

  # Search for the _brand.yml file
  brand_files <- list.files(root_dir, pattern = paste0(brand_filename, "$"),
                            recursive = TRUE, full.names = TRUE)

  if (length(brand_files) == 0) {
    stop(sprintf("No '%s' file found under %s.", brand_filename, root_dir))
  }
  if (length(brand_files) > 1) {
    stop(sprintf("Multiple '%s' files found. Please ensure only one exists.", brand_filename))
  }

  brand_yml <- brand_files[1]

  # Existing logic
  brand <<- attr(bslib::bs_theme(brand = brand_yml), "brand")
  brand_colors <<- brand$color$palette
}
