# Tools for downloading data automatically from website
# 2017 04 26


graphics.off()
rm(list=ls())
# ############################################################################
# # using the library RCUrl
install.packages("RCurl")
library(RCurl)
web = "https://looixiv.github.io/Bio381/Fish_data.txt"
getData = function(web, delimiter){
  output = getURL(web) # gets the data
  X = read.table(textConnection(output), sep = delimiter, header = T, fill = T)
  # return the output
  return(X)
}

############################################################################
# read user input
read_dw = function(){
  w = readline() # input of the user URL (where to DL data)
  return() # return the web URL
}

write.csv() # output the data to your directory

  output = getURL() # gets the data
  # return the output
  return()
}

############################################################################
# read user input
read_dw = function(){
  w = readline("Enter Web Address: ") # input of the user URL (where to DL data)
  d = readline("Enter Delimiter: ")
  if(d == "\\t" || d == "\"\\t\"" || d =="tab") d = "\t"
  output = c(w,d)
  return(output) # return the web URL
}

inputs = read_dw()

write.csv() # output the data to your directory