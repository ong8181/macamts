#' @title `make_block` function from rEDM v0.7.5
#' @description \code{make_block} generates a lagged block with the appropriate max_lag and tau, while respecting lib (by inserting NANs, when trying to lag past lib regions)
#' @param block a data.frame or matrix where each column is a time series
#' @param t Numeric. The time index for the block.
#' @param max_lag The total number of lags to include for each variable.
#' @param tau The lag to use for time delay embedding.
#' @param lib A 2-column matrix (or 2-element vector) where each row specifies the first and last *rows* of the time series to use for attractor reconstruction.
#' @param restrict_to_lib Whether to restrict the final lagged block to just the rows specified in lib (if lib exists).
#' @return A data.frame with the lagged columns and a time column. If the original block had columns X, Y, Z and max_lag = 3, then the returned data.frame will have columns TIME, X, X_1, X_2, Y, Y_1, Y_2, Z, Z_1, Z_2.
#' @details
#' \itemize{
#'  \item{Ye et al. (2018) Applications of Empirical Dynamic Modeling from Time Series. https://github.com/ha0ye/rEDM}
#' }
#' @keywords internal
make_block <- function (block, t = NULL, max_lag = 3, tau = 1, lib = NULL,
                        restrict_to_lib = TRUE) {
  if (is.vector(block)) block <- matrix(block, ncol = 1)
  num_vars <- NCOL(block)
  num_rows <- NROW(block)

  if (!is.null(lib)) {
    if (is.vector(lib)) lib <- matrix(lib, ncol = 2, byrow = TRUE)
  }
  output <- matrix(NA, nrow = num_rows, ncol = 1 + num_vars * max_lag)
  col_names <- character(1 + num_vars * max_lag)
  if (is.null(t)) output[, 1] <- 1:num_rows else output[, 1] <- t
  col_names[1] <- "time"
  col_index <- 2
  if (is.null(colnames(block))) colnames(block) <- paste0("col", seq_len(num_vars))

  for (j in 1:num_vars) {
    ts <- block[, j]
    if (is.list(ts)) {
      ts <- unlist(ts)
    }
    output[, col_index] <- ts
    col_names[col_index] <- colnames(block)[j]
    col_index <- col_index + 1
    if (max_lag > 1) {
      for (i in 1:(max_lag - 1)) {
        ts <- c(rep_len(NA, tau), ts[1:(num_rows - tau)])
        if (!is.null(lib)) {
          for (k in seq_len(NROW(lib))) {
            ts[lib[k, 1] - 1 + (1:tau)] <- NA
          }
        }
        output[, col_index] <- ts
        col_names[col_index] <- paste0(colnames(block)[j], "_", i * tau)
        col_index <- col_index + 1
      }
    }
  }
  if (!is.null(lib) && restrict_to_lib) {
    row_idx <- sort(unique(do.call(c, mapply(seq, lib[, 1], lib[, 2], SIMPLIFY = FALSE))))
    output <- output[row_idx, ]
  }
  output <- data.frame(output)
  names(output) <- col_names
  return(output)
}
