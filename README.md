
# macamts

<!-- badges: start -->
<!-- badges: end -->

macamts contains a subset of the R functions implemented in macam.

## Installation

You can install the development version of macamts from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ong8181/macamts")
```

## Manual

see [macam](https://github.com/ong8181/macam) for detail.

### Time series analysis
- `s_map_rgl()`: Perform the regularized S-map in [Cenci et al. (2019)](https://doi.org/10.1111/2041-210X.13150). A wrapper function of `extended_lnlp()`.
- `extended_lnlp()`: A generalized function for the regularized S-map. For the multivariate S-map, please use this function.
- `uic_across()`: Perform UIC across columns (for the MDR S-map) (beta version).
- `make_block_mvd()`: Generate data.frame for the calculation of multiview distance (for the MDR S-map) (beta version).
- `compute_mvd()`: Compute multiview distance (for the MDR S-map) (beta version).
- `s_map_mdr()`: Perform the MDR S-map in [Chang et al. (2021)](https://doi.org/10.1111/ele.13897)  (beta version).
- `s_map_mdr_all()`: A convenient all-in-one wrapper function for the MDR S-map. To fine-tune parameters, use step-by-step functions such as `compute_mvd()` etc (beta version).

### data
- `data_4sp`: Demo time series data for time series analysis. Data is from [Ushio et al. (2018)](https://doi.org/10.1038/nature25504).
- `asv_sheet`: A demo ASV sheet for sequence analysis. Data is from [Ushio (2019)](https://doi.org/10.1111/2041-210X.13204).
- `sample_sheet`: A demo sample sheet for sequence analysis. Data is from [Ushio (2019)](https://doi.org/10.1111/2041-210X.13204).
- `tax_sheet`: A demo taxa sheet for sequence analysis. Data is from [Ushio (2019)](https://doi.org/10.1111/2041-210X.13204).


## References
- Cenci et al. (2019) Methods in Ecology and Evolution. https://doi.org/10.1111/2041-210X.13150
- Chang et al. (2021) Ecology Letters. https://doi.org/10.1111/ele.13897
- Osada & Ushio (2020) rUIC:Unified Information-theoretic Causality for R. https://doi.org/10.5281/zenodo.5163234
- Osada et al. (2023) bioRxiv. https://doi.org/10.1101/2023.04.20.537743

