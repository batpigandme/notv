use_secret_file("tidyverse-gmail.json")

## mime stuff for email
test_email <- mime(
  To = "maraaverick@gmail.com",
  From = "mara@rstudio.com",
  Subject = "this is just a gmailr test",
  body = "Can you hear me now?"
)

send_message(test_email)

# map emails to mime ---------------------------
emails <- edat %>%
  pmap(mime)

str(emails, max.level = 2, list.len = 2)

# safe send -------------------------------------
safe_send_message <- safely(send_message)

# send actual messages -------------------------
sent_mail <- emails %>%
  map(safe_send_message)

save(sent_mail, file = here::here("inst", "emails", "sent_mail_20180330.RData"))

# inspect for errors -------------------------------------
errors <- sent_mail %>%
  transpose() %>%
  .$error %>%
  map_lgl(Negate(is.null))
sent_mail[errors]

email_errors <- data_frame(package_vec, errors) %>%
  rename("package_name" = "package_vec",
    "had_error" = "errors") %>%
  inner_join(maintainers, by = "package_name")


# save email error record ----------------------------------
write_csv(email_errors, here::here("inst", "emails", "email_errors_20180330.csv"))
