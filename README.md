# data_science_capstone

files for the data science capstone project (December 2015)

## csv files

You can click on the .csv files to view the content.

* badwords.csv (138 words that will never be predicted, foul language or proper names)
* goodwords.csv (2362 word that will be predicted by my algorithm )
* orderd_bigrams.csv (all the bi-grams that predict a good word)
* twit_best_bigram.csv (the bi-grams that will actually be used to predict the next word)

## Perl programs to produce the csv's
* 01_to_lower.pl  (clean the data + writing test and train file)
* 02_monogram_gt500.pl (make complete list of all distinct words and their frequency)
* 02_selected_words.pl (same, but only words with frequency > 500 )
* 03_make_bigram.pl (make bi-grams)
* 04_count_bigrams_gt10.pl (make bigram counts, keep when count >= 10)
* 04_selected_bigrams.pl (make selected bi-grams list) 
* 04_zfinal_bigrams.pl (make twit_best_bigram.csv)

**NOTE** The Perl programs were designed using the classic 1972 Jackson Structured Programming method, those unfamiliar with JSP might think this a very strange way of programming (it is actually very well fit for this type of programs)