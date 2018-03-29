this_hw <- "tidyverse package"
email_sender <- 'Mara Averick <mara@rstudio.com>' # your Gmail address
body <- "Dear %s,

Your package, %s, lists the tidyverse package in either Depends,
Imports, or Suggests on CRAN.

Because the tidyverse is a set of packages designed for a range of tasks, this
is, in short, a bad idea. The tidyverse package includes a substantial number
of direct and indirect dependencies (79 packages, as of this writing), many of
which are likely unnecessary for the purposes of your package. Furthermore, the
CRAN maintainers frown upon depending on it, which can cause hassle for you down
the line.

If you could please correct this by importing functions from or depending on the
tidyverse component packages you require at your nearest convenience, it would
be most appreciated.

Please let us know if you have any questions.

Thank you,

Hadley Wickham
c/o Mara Averick"

edat <- maintainers %>%
  mutate(
    To = sprintf('%s <%s>', maintainer, email),
    From = email_sender,
    Subject = sprintf('%s and the tidyverse package', package_name),
    body = sprintf(body, maintainer, package_name)) %>%
  select(one_of(c("To", "From", "Subject", "body")))

write_csv(edat, here::here("inst", "emails", "tverse_revdeps_20190329.csv"))

# edat <- my_dat %>%
#  mutate(
#    To = sprintf('%s <%s>', name, email),
#    Bcc = optional_bcc,
#    From = email_sender,
#    Subject = sprintf('Mark for %s', this_hw),
#    body = sprintf(body, name, this_hw, mark)) %>%
#  select(To, Bcc, From, Subject, body)
