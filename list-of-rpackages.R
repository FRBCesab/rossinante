#' List of Common R Packages used in Ecological Studies
#'
#' @author Nicolas Casajus (nicolas.casajus@fondationbiodiversite.fr)
#'
#' @lastupdate 2021/09/03
#'
#' @notes Some other packages will be installed. For instance, installing the
#' package `rmarkdown` will also install `knitr`, `htmltools`, `jsonlite`,
#' `tinytex`, and `stringr` (among others).
#' A total of 459 packages will be installed (2.1GB).  

## CRAN Packages ----

install.packages(

  pkgs = c(

    ## The Tidy-verse ----
    "rlang", "tidyverse",

    ## Package development ----
    "available", "BiocManager", "devtools", "formatR", "goodpractice",
    "hexSticker", "pkgdown", "rhub", "usethis",

    ## Compendium/Workflow ----
    "here", "rcompendium", "rens", "targets",

    ## Ecological analyses ----
    "ade", "adehabitatHR", "adehabitatHS", "betapart", "biomod2", "factoextra",
    "mclust", "sdmpredictors", "vegan",

    ## Bayesian analyses ----

    "brms", "nimble", "R2jags", "rstan",

    ## Phylogeny ----
    "ape",

    ## Data i/o ----
    "foreign", "RSQLite", "writexl",

    ## Vizualisation ----
    "corrplot", "cowplot", "dendextend", "ggimage", "ggpubr", "ggraph",
    "ggrepel", "ggsignif", "ggthemes", "gridExtra", "highcharter", "patchwork",
    "showtext", "vioplot", "wordcloud2",

    ## Colors ----
    "colorspace", "fishualize", "RColorBrewer", "wesanderson",

    ## Text extraction ----
    "bib2df", "bibtex", "fulltext", "pdftools", "stringdist", "stringi", "tm",

    ## Reporting/Website ----
    "blogdown", "bookdown", "extrafont", "fontawesome", "kableExtra",
    "pagedown", "revealjs", "rmarkdown", "rticles", "xaringan",

    ## Spatial ----
    "geojsonsf", "geosphere", "leaflet", "maps", "maptools", "mapview",
    "raster", "rgdal", "rgeos", "rnaturalearth", "rnaturalearthdata", "sf",
    "sp", "stars", "terra",

    ## Image processing ----
    "imager", "jpeg", "magick", "png", "tiff",

    ## Others ----
    "curl", "RCurl", "shiny", "taxize"
))


## GitHub Packages ----

remotes::install_github("hadley/emo")
remotes::install_github("frbcesab/worldpa")
remotes::install_github("ahasverus/orthomap")
remotes::install_github("gadenbuie/xaringanthemer")
remotes::install_github("yutannihilation/ggsflabel")
remotes::install_github("ropensci/rnaturalearthhires")
