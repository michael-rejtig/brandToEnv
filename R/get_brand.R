#' Load Quarto branding elements into global environment
#'
#' Searches for a brand.yml file and loads branding information.
#'
#' @param root_dir Root directory to start search.
#' @param brand_filename Name of the branding YAML file.
#' @return Invisible NULL. Sets brand/brand_colors in global environment.
#' @examples
#' get_brand()
#' @importFrom rlang check_installed
#' @importFrom bslib bs_theme
#' @importFrom yaml yaml.load_file
#' @export

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
