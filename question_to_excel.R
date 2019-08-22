#create excel file
require(tidyverse)
require(openxlsx)



#load in template excel file with outline
wb <- loadWorkbook('prime_survey_outline.xlsx')


#generate list dataframes by loading in csvs from question_to_csv.R

filenames <- list.files('csv')

names <- str_remove(filenames, ".csv")

filelist <- list()

for (i in 1:16) {
  path <- paste0('csv/', filenames[i])
  filelist[[i]] <- read_csv(path)
  
}

#give names to each element in the list of files
names(filelist) <- names

#add the dataframes to the worksheets

  #load in redcap export and the list of column names in the correct order
  Prime_data <- read_csv("PremeetingRequestFor_DATA_2019-08-20_1544.csv", na = c(""))
  col_names = names(Prime_data[6:21])

  
#add one worksheet per question into the excel workbook
  
  #create style to bold top row
  style1 <- createStyle(fontSize = 14, textDecoration = "bold", wrapText = T)
  #create style for response column
  style2 <- createStyle(fontSize = 14, wrapText = T)
  
  for (i in col_names) {
  
  #add worksheet with name of question
  addWorksheet(wb, i)
  #load in the responses from filelist
  writeData(wb, sheet = i, x = filelist[[i]])
  #freeze top pane
  freezePane(wb, i, firstRow = T)
  #set width columns
  setColWidths(wb, i, cols = c(1,2), widths = c(10,128))
  #apply style to 2nd column
  addStyle(wb, sheet = i, style2, rows = 1:999, cols = 2)
  #apply stype to top row
  addStyle(wb, sheet = i, style1, rows = 1, cols = 1:2)

}

#set column width of outline sheet
setColWidths(wb, 'Outline', 1, 13)
  
#export workbook
saveWorkbook(wb, "PRIME_survey_reponses.xlsx", overwrite = T)
