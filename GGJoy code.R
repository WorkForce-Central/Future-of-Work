#GGJoy plot for AI forum
library("ggridges", lib.loc="~/R/win-library/3.5")
library("ggplot2", lib.loc="~/R/win-library/3.5")
library(pacman)
library(data.table)
library(tidyverse)
library(hrbrthemes)
rm(list=ls())
setwd("C:/Users/jstovall/Desktop/WorkForce Central/Research & Data - Data Requests Library/Demographic Data by Occupation & Industry (PUMS)/Frey Occupation Data")
freydata <-fread("GGJOY Data.csv")
colnames(freydata) <- make.unique(names(freydata))


freydata <- group_by(freydata, SOC2digit) %>%
  mutate(m=1/mean(Order)) %>%
  arrange(m) %>%
  ungroup() %>%
  mutate(SOC2digit=factor(SOC2digit, unique(SOC2digit)))

library(reshape)
untable(freydata, num = freydata$'Empl(PlaceofWork)')

freydata <- transform(freydata[rep(1:nrow(freydata), freydata$'Empl(PlaceofWork)'), ], 
          count = 1)

ggplot(freydata, aes(x = Probability, y =SOC2digit, group=SOC2digit, fill=SOC2digit)) +geom_density_ridges2()+
  geom_density_ridges(jittered_points = TRUE)+
theme_ipsum_tw()+ theme(legend.position="none")+xlab('')+ylab('')




rm(list=ls())
setwd("C:/Users/jstovall/Desktop/WorkForce Central/Research & Data - Data Requests Library/Demographic Data by Occupation & Industry (PUMS)/Frey Occupation Data")
freyDemodata <-fread("2Digit Demographic.csv")
colnames(freyDemodata) <- make.unique(names(freyDemodata))
library(reshape)
untable(freyDemodata, num = freyDemodata$Total)
freyDemodata <- transform(freyDemodata[rep(1:nrow(freyDemodata), freyDemodata$Total), ], 
                      count = 1)
pseudocount('Weighted Prob')
freyDemodata %>% subset(!is.na('Weighted Prob')) %>% ggplot(freyDemodata, aes(x = 'Weighted Prob', y=as.factor(Demographic), fill=as.factor(Sex))) +
  geom_density_ridges2() +
  scale_x_continuous(expand = c(0, 1))

ggplot(freyDemodata, aes(x = 'Weighted Prob', y =Sex, group=Sex, fill=Demographic)) +geom_density_ridges2()+
  geom_density_ridges(jittered_points = FALSE)+
  theme_ipsum_tw()+ theme(legend.position="none")+xlab('')+ylab('')
