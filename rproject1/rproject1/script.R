pacman::p_load(dplyr, httr, magrittr, stringr, ggplot2, mosaic)

httr::GET(url = 'https://data.medicare.gov/views/bg9k-emty/files/2eed33f4-d8c8-4ed7-8aed-e4ca2885cb0a?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip', write_disk('data.zip'))
unzip('data.zip', exdir = 'data')
list.files(pattern = glob2rx("*.csv")) %>%
  unlink()

komplikationer <- read.csv("data/complications - hospital.csv", na.strings = c(" Not Available", "Not Available"))
hospitaler <- read.csv("data/hospital general information.csv", na.strings = c(" Not Available", "Not Available"))

mosaic::mean(Denominator~Measure.Name, data=komplikationer, na.rm = T)

komplikationer %>%
filter(Measure.Name == 'Collapsed lung due to medical treatment') %>%
mutate(count = Score * Denominator/100) %>%
ggplot(aes(count)) + geom_histogram()

komplikationer %>%
filter(Measure.Name == 'Collapsed lung due to medical treatment') %>%
ggplot(aes(x=Compared.to.National, y=Score)) + geom_boxplot()

