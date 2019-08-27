require(rmarkdown)

input_path <- "redcap_export/PremeetingRequestFor_DATA_2019-08-27_1756.csv"

#Control script to run in order to update files for the website
source('question_to_csv.R')
source('question_to_excel.R')
source('create_wordcloud.R')

#rename columns in datasets to ID and Response
rename_col <- function(x) {
  
  a <- x %>% dplyr::rename("ID" = 1, "Response" = 2)
  return(a)
  
}

filelist2 <- map(filelist, rename_col)

#export filelist
save(filelist2, file = 'filelist2.RData')

#render markdown to html 
rmarkdown::render(input = "Website_doc.Rmd", output_file = "index.html")
