#! Rscript  
cat("\n   Building all .Rmd files in directory.\n   -------------------------------------\n")

# Preprocessing ----
cat("\n-> Preprocessing\n   -------------\n")

# Get files
files <- dir(full.names = TRUE, recursive = TRUE)
rmd_files  <- files[grepl("\\.Rmd$", files)]
rmd_files  <- rmd_files[!grepl("example", basename(rmd_files))]
html_files <- files[grepl("\\.html$", files)]
pdf_files  <- files[grepl("\\.pdf$",  files)]
log_files  <- files[grepl("\\.log$",  files)]
cat("   [", format(Sys.time(), "%T"), "]", length(rmd_files), ".Rmd files found.\n")

# Check and potentially install missing packages
cat("   [", format(Sys.time(), "%T"), "] Checking for missing packages...\n")
pcks_lines <- unique(unlist(sapply(rmd_files, function(filename) {
  ln <- suppressWarnings(readLines(filename))
  ln[grepl("^library\\(\\w+\\)$", ln, perl = TRUE)]
})))
need_pcks <- c(gsub("\\)", "", gsub("library\\(", "", pcks_lines)), "knitr", "rmarkdown")
inst_pcks <- installed.packages()[,1]
to_install <- need_pcks[!need_pcks %in% inst_pcks]
if (length(to_install) > 0) {
  cat("   [", format(Sys.time(), "%T"), "] Installing the following packages:\n", 
      paste("     -", to_install, collapse = "\n"))
  try(install.packages(to_install))
}

# Check that pandoc is available
cat("   [", format(Sys.time(), "%T"), "] Checking that pandoc is available...\n")
if (interactive()) {
  while (!rmarkdown::pandoc_available()) {
    resp <- readline("   + Pandoc is not available. Provide a full path to the binary folder here or type q to exit: ")
    if (resp == "q") quit("n")
  }
} else {
  if (!rmarkdown::pandoc_available()) {
    stop("   + Pandoc is not available. Add it to your system path.")
  }
}

# Clean html and pdfs
cat("   [", format(Sys.time(), "%T"), "] Removing compiled files...\n")
suppressWarnings(removed <- file.remove(c(html_files, pdf_files)))
cat("   [", format(Sys.time(), "%T"), "] Removed", sum(removed), "compiled files.\n")


# Compilation ----
# Build all the r markdown files in the folder
cat("\n-> Starting compilation\n   --------------------\n")


compile <- function(rmd_files) {
  mes <- "Messages: \n"
  out <- "Output: \n"
  on.exit({
    writeLines(out, "output.log")
    writeLines(mes, "message.log")
    quit("no", status = 1)
  })
  
  for (rmd_file in rmd_files) {
    cat("   [", format(Sys.time(), "%T"), "] Compiling", basename(rmd_file), "... ")
    trunk <- substr(rmd_file, start = 0, stop = nchar(rmd_file) - 4)
    out <- c(out, capture.output(
      mes <- c(mes, capture.output(
        pcks <- sessionInfo()$otherPkgs,
        if (length(pcks) > 0) {
          invisible(sapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, 
                           character.only = TRUE, unload = TRUE, force = TRUE))
        },
        rmarkdown:::render(rmd_file, output_format = "html_document",
                           params = list(answers = TRUE)),
        invisible(file.rename(paste0(trunk, ".html"), paste0(trunk, "_answers.html"))),
        rmarkdown:::render(rmd_file, output_format = "html_document",
                           params = list(answers = FALSE)),
        rmarkdown:::render(rmd_file, output_format = "pdf_document",
                           params = list(answers = FALSE)),
        invisible(file.remove(paste0(trunk, ".tex"))),
        type = "message"
      )),
      type = "output"
    ))
    
    on.exit()
    writeLines(out, "output.log")
    writeLines(mes, "message.log")
    
    cat("done.\n")
  }
}

compile(rmd_files)
cat("-> Compilation done.\n-> See output.log for compilation output.\n-> See message.log for R messages.\n")

quit("no", status = 0)

