// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppEigen.h>
#include <Rcpp.h>

using namespace Rcpp;

// CD
List CD(int node, int dataSize, Eigen::Map<Eigen::MatrixXi> data, Eigen::Map<Eigen::VectorXi> nlevels, List obsIndex_R, int eor_nr, Eigen::Map<Eigen::MatrixXi> eor, Eigen::Map<Eigen::VectorXd> lambda_seq, int nlam, double eps, double convLb, double qtol, Eigen::Map<Eigen::MatrixXd> weights, double gamma, double upperbound, int threshold);
RcppExport SEXP discretecdAlgorithm_CD(SEXP nodeSEXP, SEXP dataSizeSEXP, SEXP dataSEXP, SEXP nlevelsSEXP, SEXP obsIndex_RSEXP, SEXP eor_nrSEXP, SEXP eorSEXP, SEXP lambda_seqSEXP, SEXP nlamSEXP, SEXP epsSEXP, SEXP convLbSEXP, SEXP qtolSEXP, SEXP weightsSEXP, SEXP gammaSEXP, SEXP upperboundSEXP, SEXP thresholdSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type node(nodeSEXP);
    Rcpp::traits::input_parameter< int >::type dataSize(dataSizeSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::MatrixXi> >::type data(dataSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::VectorXi> >::type nlevels(nlevelsSEXP);
    Rcpp::traits::input_parameter< List >::type obsIndex_R(obsIndex_RSEXP);
    Rcpp::traits::input_parameter< int >::type eor_nr(eor_nrSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::MatrixXi> >::type eor(eorSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::VectorXd> >::type lambda_seq(lambda_seqSEXP);
    Rcpp::traits::input_parameter< int >::type nlam(nlamSEXP);
    Rcpp::traits::input_parameter< double >::type eps(epsSEXP);
    Rcpp::traits::input_parameter< double >::type convLb(convLbSEXP);
    Rcpp::traits::input_parameter< double >::type qtol(qtolSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::MatrixXd> >::type weights(weightsSEXP);
    Rcpp::traits::input_parameter< double >::type gamma(gammaSEXP);
    Rcpp::traits::input_parameter< double >::type upperbound(upperboundSEXP);
    Rcpp::traits::input_parameter< int >::type threshold(thresholdSEXP);
    __result = Rcpp::wrap(CD(node, dataSize, data, nlevels, obsIndex_R, eor_nr, eor, lambda_seq, nlam, eps, convLb, qtol, weights, gamma, upperbound, threshold));
    return __result;
END_RCPP
}
// lambdaMax
double lambdaMax(int node, int dataSize, Eigen::Map<Eigen::MatrixXi> data, Eigen::Map<Eigen::VectorXi> nlevels, List obsIndex_R, Eigen::Map<Eigen::MatrixXd> weights, double gamma, double upperbound);
RcppExport SEXP discretecdAlgorithm_lambdaMax(SEXP nodeSEXP, SEXP dataSizeSEXP, SEXP dataSEXP, SEXP nlevelsSEXP, SEXP obsIndex_RSEXP, SEXP weightsSEXP, SEXP gammaSEXP, SEXP upperboundSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type node(nodeSEXP);
    Rcpp::traits::input_parameter< int >::type dataSize(dataSizeSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::MatrixXi> >::type data(dataSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::VectorXi> >::type nlevels(nlevelsSEXP);
    Rcpp::traits::input_parameter< List >::type obsIndex_R(obsIndex_RSEXP);
    Rcpp::traits::input_parameter< Eigen::Map<Eigen::MatrixXd> >::type weights(weightsSEXP);
    Rcpp::traits::input_parameter< double >::type gamma(gammaSEXP);
    Rcpp::traits::input_parameter< double >::type upperbound(upperboundSEXP);
    __result = Rcpp::wrap(lambdaMax(node, dataSize, data, nlevels, obsIndex_R, weights, gamma, upperbound));
    return __result;
END_RCPP
}
