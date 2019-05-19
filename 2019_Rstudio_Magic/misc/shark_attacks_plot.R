library(wesanderson)
library(ggplot2)

attacks<-read.csv('./misc/global_shark_attacks.csv', stringsAsFactors = F)

attacks <- head(attacks, 8)
attacks$Country <- factor(attacks$Country, attacks$Country)

ggplot(data=attacks, aes(x = Country, y = Total, fill = Country)) +
  geom_bar(stat = "identity") +
  xlab("Countries") +
  ylab("Total Shark Attacks") +
  ggtitle("Top countries with shark attacks\n(Esteban was eaten)") +
  scale_fill_manual(values = wes_palette("Zissou1",8, type="continuous")) +
  theme(axis.text.x = element_text(angle = 35, hjust = 1)) + 
  theme(plot.title = element_text(hjust = 0.5))
