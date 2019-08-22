#function to create wordcloud
require("tm") # for text mining
require("SnowballC") # for text stemming
require("wordcloud") # word-cloud generator
require("RColorBrewer") # color palettes


create_wordcloud <- function(x)  {

test <- Corpus(VectorSource(x))

#inspect(test)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
test <- tm_map(test, toSpace, "/")
test <- tm_map(test, toSpace, "@")
test <- tm_map(test, toSpace, "\\|")

# Convert the text to lower case
test <- tm_map(test, content_transformer(tolower))
# Remove numbers
test <- tm_map(test, removeNumbers)
# Remove english common stopwords
test <- tm_map(test, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
test <- tm_map(test, removeWords, 
               c("can", "use", "put", "least", "must", "nhp", "NHP", "scanner", "coil", "coils")) 
# Remove punctuations
test <- tm_map(test, removePunctuation)
# Eliminate extra white spaces
test <- tm_map(test, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(test)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
#head(d, 10)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

}



#create all wordclouds and export to PNG

#dir.create('wordclouds')



for (i in names(filelist)) {
  
  jpeg(filename=paste0("wordclouds/", i, ".jpg"), quality = 150)
  create_wordcloud(filelist[[i]])
  dev.off()

  
}

