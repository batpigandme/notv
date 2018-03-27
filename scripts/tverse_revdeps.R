suppressPackageStartupMessages(library(tidyverse))
library(crandb)
tverse_crandb <- package("tidyverse")

# function to get maintainer ------------------------------
get_maintainer <- function(pkg){
  pkg_crandb <- crandb::package(pkg)
  pkg_crandb[["Maintainer"]]
}

# get tidyverse reverse depends and imports ----------------
packages <- tools::package_dependencies(
  packages = "tidyverse",
  which = c("Depends", "Imports"), reverse = TRUE
)

# package names to character vector ------------------------
package_list <- c(packages[["tidyverse"]])

# unnest packages into tibble -------------------------------
tverse_revdeps <- tibble::tibble(packages) %>%
  unnest() %>%
  rename("package_name" = "packages") %>%
  mutate(url = str_glue("https://CRAN.R-project.org/package={package_name}"))

# works for one ---------------------------------------------
get_maintainer(package_list[2])
