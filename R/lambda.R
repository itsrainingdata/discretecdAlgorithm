#' A method to calculate the value of maximum lambda along a solution path
#'
#' @param indata A sparsebnData object
#' @param weights Weight matrix
#' @param gamma A postitive number to scale weight matrix.
#' @param upperbound A large positive value used to truncate the adaptive weights. A -1 value indicates that there is no truncation.
#' @return The maximum lambda along the solution path.
#' @export
max_lambda <- function(indata,
                   weights = NULL,
                   gamma=1.0,
                   upperbound = 100.0) {

  lambda_call(indata = indata,
          weights = weights,
          gamma = gamma,
          upperbound = upperbound)

}

# Convert input to the right form.
lambda_call <- function(indata,
                    weights,
                    gamma,
                    upperbound) {

  # Allow users to input a data.frame, but kindly warn them about doing this.
  # if the input is a dataframe, the data set is treated as an observational data set.
  # ivn will be initialized to be a list of length dataSize, and every element is 0.
  if(is.data.frame(indata)){
    warning(sparsebnUtils::alg_input_data_frame())
    dataSize <- nrow(indata)
    ivn <- vector("list", length = dataSize)
    ivn <- lapply(ivn, function(x){
      return(c(0L))
    })
    data <- sparsebnUtils::sparsebnData(indata, ivn = ivn, type = "discrete")
  }
  else {
    data <- indata
  }

  # Check data format
  if(!sparsebnUtils::is.sparsebnData(data)) stop(sparsebnUtils::input_not_sparsebnData(data))

  # Extract the data and the intervention list.
  data_matrix <- data$data
  data_matrix <- as.data.frame(sapply(data_matrix, function(x){as.integer(x)}))
  data_ivn <- data$ivn
  data_level <- data$levels

  # Get the dimensions of the data matrix
  dataSize <- nrow(data_matrix)
  node <- ncol(data_matrix)

  # the input data_matrix should be a matrix
  data_matrix <- as.matrix(data_matrix)

  # get n_levels.
  n_levels <- as.integer(sapply(indata$levels, function(x){length(x)}))

  # get observational index (obsIndex_R) from interventional list (ivn)
  obsIndex_R <- get_obsIndex(data_ivn, node)

  # make sure that for each observation, at least on node is not under intervention. If all nodes are under intervention, stop and require user to remove that observation.
  ind <- 1:node
  is_obs_zero <- sapply(obsIndex_R, function(x){x==0})
  if(length(ind[is_obs_zero])!=0) {
    stop(sprintf("%d th node has been intervened in all observations, remove this node \n", ind[is_obs_zero]))
  }

  # minus 1 from all elements in obsIndex_R to incorporate with C++.
  obsIndex_R <- lapply(obsIndex_R, function(x) {as.integer(x-1)})

  # check/generate weight matrix
  if(is.null(weights)) {
    weights <- matrix(1, node, node)
  }
  weights <- matrix(as.numeric(weights), ncol = node)

  # type conversion for tunning parameters
  node <- as.integer(node)
  dataSize <- as.integer(dataSize)
  gamma <- as.numeric(gamma)
  upperbound <- as.numeric(upperbound)

  # run CD algorithm
  max_lambda <- calc_lambda(node,
                      dataSize,
                      data_matrix,
                      n_levels,
                      obsIndex_R,
                      weights,
                      gamma,
                      upperbound)

  return(max_lambda)
}

# a function that directly calls from cpp
# type check, no converting type of an input at this point
calc_lambda <- function(node,
                    dataSize,
                    data_matrix,
                    n_levels,
                    obsIndex_R,
                    weights,
                    gamma,
                    upperbound) {
  # check node parameter
  if(!is.integer(node)) stop("node must be a integer!")
  if(node <= 0) stop("node must be a positive integer!")

  # check dataSize parameter
  if(!is.integer(dataSize)) stop("dataSize must be a integer!")
  if(dataSize <= 0) stop("dataSize must be a positive integer!")

  # check data_matrix
  if(node!=ncol(data_matrix) || dataSize!=nrow(data_matrix)) stop("dimension does not match. node should be the number of columns of data matrix, and dataSize should be numbe of rows of data matrix.")
  if(sum(sapply(data_matrix, function(x){!is.integer(x)}))!=0) stop ("data_matrix has to be a data.frame with integer entries!")

  # check n_levels
  if (!is.integer(n_levels)) stop("n_levels must be a vector of integers!")
  if (length(n_levels)!=node) stop("Length of n_levels does not compatible with the input data set. n_levels must be a vector of length equals to the number of node!")

  # check obsIndex_R
  if (!is.list(obsIndex_R)) stop("obsIndex_R must be a list!")
  if (sum(sapply(obsIndex_R, function(x){!is.integer(x)}))!=0) stop("element of obsIndex_R must be a vector of integers!")
  if (sum(sapply(obsIndex_R, function(x){sum(x<0)}))!=0) stop("element of obsIndex_R must be a positive number!")
  if (length(obsIndex_R)!=node) stop("obsIndex_R must be a list of length equals to the number of nodes!")

  # check weights
  if (!is.numeric(weights)) stop("weights must be a numeric matrix!")
  if (is.integer(weights)) stop("weights must not be an integer matrix!")
  if (ncol(weights)!=node || nrow(weights)!=node) stop("weigths must be a matrix with both number of rows and columns equal to number of variables!")

  # check gamma
  if (!is.numeric(gamma)) stop("gamma must be a numeric number!")
  if (gamma<=0) stop ("gamma must be a positive number!")

  # check upperbound
  if (!is.numeric(upperbound)) stop("upperbound must be a numeric number!")
  if (upperbound <= 0 && upperbound!=-1) stop("upperbound must be a large positive integer to truncate the adaptive weights. Or it can be -1, which indicates that there is no truncation!")

  max_lambda <- lambdaMax(node,
               dataSize,
               data_matrix,
               n_levels,
               obsIndex_R,
               weights,
               gamma,
               upperbound)

  return(max_lambda)
}