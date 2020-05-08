#--------------------------------------------- Created by Daniel Carvalho ------------------------------------------------------------
# Created for Dr. Kreymerman's research at Florida Atlantic University.
# Purpose:  This code is for converting excel files into CSV files. CSV files are easier for R to read and has less chance of bugs.  

install.packages("rio")  #used to install "rio" package which is used for data input/output
library("rio")  #loads "rio" package
library("openxlsx")  #loads excel file handler package named "openxlsx"

setwd("C:/Users/zebra/Documents/Research/LaserTrapping/") #Sets files' working directory
setwd("2mkm/SelectedData/") #Sets files' working directory in different folder

#Notes: 
# (general) Make sure names have number like 01, 02, 03, ...13, ..., 22, etc. and NOT like 1, 2, 3, ..., 13, ..., 22, etc. 
#           Otherwise the conversions will go in the order of 1, 13, 2, 22, 3, etc. 
#           If you do the proper method of naming then it will be in the order of 01, 02, 03, ..., 13, ..., 22, etc.

#Begin conversion ------------------------------------------------------------------------------------------------------------------

#using rio
xls <- dir(pattern = "xlsx")  #Set path to xlsx files
created <- mapply(convert, xls, gsub("xlsx", "csv", xls))  #convert all files in path

#End conversion --------------------------------------------------------------------------------------------------------------------

#testing\/ -------------------------------------------------------------------------------------------------------------------------

##test using rio on 1 file
convert("DataVideo2.xlsx", "DataVideo2.csv")


?mapply
?convert
?gsub
