# load packages ---------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
library(crandb)

# get tidyverse reverse depends, imports, suggests  ----------------
packages <- tools::package_dependencies(
  packages = "tidyverse",
  which = c("Depends", "Imports", "Suggests"), reverse = TRUE
)

# package names to character vector ------------------------
package_vec <- packages[["tidyverse"]]

# package names to list -------------------------------------
package_list <- as.list(packages[["tidyverse"]])

# function to get maintainer ------------------------------
get_maintainer <- function(pkg) {
  pkg_crandb <- crandb::package(paste(pkg))
  pkg_crandb[["Maintainer"]]
}

# unnest packages into tibble -------------------------------
tverse_revdeps <- tibble::tibble(packages) %>%
  unnest() %>%
  rename("package_name" = "packages") %>%
  mutate(url = str_glue("https://CRAN.R-project.org/package={package_name}"))

# works for one ---------------------------------------------
# get_maintainer(package_vec[2])
# get_maintainer(tverse_revdeps$package_name[1])

# package_list[[1]]
# crandb::package(package_list[[1]])

# crandb::package(package_vec[1])
# map(package_vec, get_maintainer)

# for loop version --------------------------------------------------------
df <- data.frame(col = list()) # define list col
for (i in 1:length(package_vec)) {
  col <- get_maintainer(package_vec[i])
  df[i, 1] <- col # places the first result into row i, column 1
}
df <- as.tibble(df)

# maintainers frame -------------------------------------------------------
maintainers <- df %>%
  separate(V1, sep = "<", into = c("maintainer", "email")) %>%
  separate(email, sep = ">", into = c("email", "blah")) %>%
  select(one_of(c("maintainer", "email"))) %>%
  add_column(package_name = c(package_vec)) %>%
  mutate(maintainer = str_trim(maintainer))

# save -------------------------------------------------------------------
date_string <- as.character(Sys.Date())
write_csv(maintainers, here::here("inst", "data",
                                  str_glue("revdep_maintainers_{date_string}.csv")))
