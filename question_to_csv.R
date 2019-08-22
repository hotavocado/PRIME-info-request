#Generate .csv files for each question in the survey
require(tidyverse)


Prime_data <- read_csv("PremeetingRequestFor_DATA_2019-08-20_1544.csv", na = c(""))



questions = c('1. What elements do you believe are most essential for inclusion in such a movie stimulus (e.g., conspecific individuals, faces, bodies, social and non-social, interactions, vocalizations, other sounds...)?',
              '2. How would you order these elements based on priority?',
              '1. What software package(s) do you use for data analysis?',
              '2. What hacks were required to make these packages work for NHP data?',
              '3. What are the main problems (preprocessing, analyses) that you run into and that the community needs to solve for NHP data?',
              '4. Do you rely primarily on volume or surface-based approaches for inter-subject registration? Is there a particular reason as to why?',
              '1. What type of scanner and head coil(s) does your work rely on? Are there any specific advantages?',
              '2. What image sequence types do you obtain in all studies? (e.g., T1W, T2W, dMRI, fMRI, field map); for each modality, what spatial resolution and (if used) multi-band factor?',
              '3. Are you using MION or other iron-based contrast agents? If so, what specific agent and dose?',
              '4. If you use anesthesia, what specific type and levels do you use?',
              '5. What protocols have you applied to do awake imaging (e.g., Do you obtain eye-tracking in the scanner? What physiologic measures?)?',
              '6. What protocols are you using to optimize various acquisition parameters? Or rather, what are the tools and parameters you use to assess the quality of your acquisition?',
              '7. What acquisition standards do you feel are required for surface-based or volume based processing and registration?',
              '8. What do you use for distortion correction and acquisition for Mion vs BOLD sequences?',
              '9. What would you like to see as a \'standard\' for acquisition sequences across community and PRIME contributors?',
              '10. If you would like to provide any additional suggestions or information, please do so here.')

col_names = names(Prime_data[6:21])

#rename columns into actual question
Prime_data <- Prime_data %>% rename_at(col_names, ~paste0(questions))

#subtract 'record_id' by 1, since first record is test by Lei
Prime_data <- Prime_data %>% mutate(record_id = record_id - 1)

dir.create('csv')


#turn questions into csv
separate_csv <- function(x) {
  
  qdata <- Prime_data %>% select(record_id, questions[x])
  
  write_csv(qdata, paste0("csv/", col_names[x], ".csv"))

  }
  

for (i in 1:16) separate_csv(i)
  


  
  