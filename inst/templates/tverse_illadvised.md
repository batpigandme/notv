Dear {maintainer},

As of {date}, your package, {package_name}, lists the tidyverse package in
either Depends, Imports, or Suggests on CRAN.

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
c/o Mara Averick
