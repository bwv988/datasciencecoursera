# Data Cleaning Project

## Introduction

The goal of this data cleaning exercise is to generate a condensed and cleaned data set based on the "Human Activity Recognition Using Smartphones Data Set" data set.

## Using the script

In order to run the script, the original data set must be obtained as a zip file from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The run_analysis.R script assumes that the contents of the zip file has been extracted into the "UCI HAR Dataset" subdirectory.

If this is so, the script can be sourced into the R environment via the source() command, and run as follows:

```R
source('run_analysis.R')
res <- MergeSets()
```

The resulting variable will contain two dataframes, "data" and "data.new".

The dataframe "data.new" is the final, cleaned data set:

```R
str(res$data.new) 
'data.frame':  180 obs. of  81 variables:
$ Mean.of.tBodyAcc.mean.X              : chr  "0.276426586440678" "0.278582015166667" "0   .278502842115385" "0.278574076603774" ...
...
```

## Codebook

Data transformations and general cleaning approach is described in the file Codebook.md.