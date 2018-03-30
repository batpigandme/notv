date <- Sys.Date()
email_sender <- 'Mara Averick <mara@rstudio.com>' # your Gmail address
body <- "Dear %s,

As of %s, your package, %s, lists the tidyverse package in either Depends,
Imports, or Suggests on CRAN.

Because the tidyverse is a set of packages designed for interactive data
analysis, this is, in short, a bad idea. The tidyverse package includes a
substantial number of direct and indirect dependencies (79 packages, as of this
writing), many of which are likely unnecessary for the purposes of your package.
Furthermore, the CRAN maintainers frown upon depending on it, which can cause
hassle for you down the line.

If you could please correct this by importing functions from, suggesting,
or depending on the tidyverse component packages you require at your nearest
convenience, it would be most appreciated.

Please let us know if you have any questions.

Thank you,

Hadley Wickham
c/o Mara Averick"

edat <- maintainers %>%
  mutate(
    To = sprintf('%s <%s>', maintainer, email),
    From = email_sender,
    Subject = sprintf('%s and the tidyverse package', package_name),
    body = sprintf(body, maintainer, date, package_name)) %>%
  select(one_of(c("To", "From", "Subject", "body")))

write_csv(edat, here::here("inst", "emails", str_glue("tverse_revdeps_{date_string}.csv")))

# edat <- my_dat %>%
#  mutate(
#    To = sprintf('%s <%s>', name, email),
#    Bcc = optional_bcc,
#    From = email_sender,
#    Subject = sprintf('Mark for %s', this_hw),
#    body = sprintf(body, name, this_hw, mark)) %>%
#  select(To, Bcc, From, Subject, body)
