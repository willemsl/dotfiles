# prevent HOME clutter
r_lib_path <- "~/.local/share/r-lib"

# choose a default CRAN
options(repos=structure(c(CRAN="https://cran.uni-muenster.de/")))

if (dir.exists(r_lib_path)) {
   .libPaths(r_lib_path)
} else {
# make sure, the r_lib_path directory exists
   dir.create(r_lib_path)
   .libPaths(r_lib_path)
}


