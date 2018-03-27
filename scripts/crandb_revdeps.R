#' crandb_revdeps
#'
#' @param pkg
#'
#' @return tibble
#' @export
#'
#' @examples
# from pkgreport
crandb_revdeps <- function(pkg) {
  url <- paste0("https://crandb.r-pkg.org/-/revdeps/", pkg)
  resp <- httr::GET(url)
  httr::stop_for_status(resp)

  json <- httr::content(resp, "parsed")
  if (length(json) == 0) {
    return(tibble())
  }

  json[[1]] %>%
    purrr::map_int(length) %>%
    tibble::enframe("type", "count") %>%
    tibble::add_column(pkg = pkg, .before = 0)
}
