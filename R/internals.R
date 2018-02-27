#' @importFrom utils packageDescription
PKG_git_hash <- function(){
    pd <- packageDescription("PKG")
    gh_file <- system.file("GIT.HASH", package="PKG")

    if(!is.null(pd$RemoteSha)){ # devtools install
        return(pd$RemoteSha)
    } else if(file.exists(gh_file)){
        return(readLines(gh_file))
    } else {
        NA
    }
}


#' Session Info used for Bug Reporting
#'
#' A helper function which prints information useful in
#' bug reports.
#'
#' @return None. Called for side-effects (printed to the screen)
#'        only.
#' @export
#' @importFrom utils sessionInfo
PKG_session_info <- function(){
    old_print <- options(max.print=9999)
    on.exit(options(old_print))

    cat("PKG Git Hash: ", PKG_git_hash(), "\n")

    if(requireNamespace("devtools")){
        print(devtools::session_info("PKG"))
    } else {
        print(sessionInfo())
    }

    invisible(NULL)
}

