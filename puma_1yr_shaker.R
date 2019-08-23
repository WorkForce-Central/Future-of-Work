library(pacman)
library(data.table)
library("survey", lib.loc="~/R/win-library/3.5")
library("tidyselect", lib.loc="~/R/win-library/3.5")
library("tidyverse", lib.loc="~/R/win-library/3.5")

#String Variables are brought in as factors
options(stringsAsFactors = T)
#Variances are centered around the estimate rather than the mean of the replicate weights
options(survey.replicates.mse = T)
#Remove Scientific Notation
options(scipen = 999)
#Number of printed digits
options(digits = 2)
#fread creates data.frames instead of data.tables
options(datatable.fread.datatable=F)
#Clear environment
rm(list=ls())
#*********************************************************
#set working directory
setwd("C:/Users/jstovall/Desktop/WorkForce Central/Research & Data - Data Requests Library/Demographic Data by Occupation & Industry (PUMS)")

#Read person level records and convert column names to lower case
#wa_p <-fread("migcode11503.csv")
wa_p <-fread("PUMS blended1.csv",colClasses = c("PUMA"="character", "SOCP"="character", "NAICSP"="character", "SEX"="character", "RAC1P"="character"))
colnames(wa_p)<-tolower(colnames(wa_p))


#********************************************************
#person-level survey design
p_design<-svrepdesign(weights= ~pwgtp,
                      repweights = 'pwgtp[0-9]+',
                      scale=4/80,
                      rscales = ncol('pwgtp[0-9]+'),
                      mse=T,
                      combined.weights = T,
                      type='BRR',
                      data= wa_p)


p_design_lthsd<-subset(p_design, schl=='Less_Than_HSD')
p_design_hsd<-subset(p_design, schl=='HSD_GED')
p_design_some<-subset(p_design, schl=='Some_College')
p_design_associate<-subset(p_design, schl=='Associate_Degree')
p_design_bachelor<-subset(p_design, schl=='Bachelor_Degree_or_Higher')
svytotal(~socp,p_design_lthsd)
svytotal(~socp,p_design_hsd)
svytotal(~socp,p_design_some)
svytotal(~socp,p_design_associate)
svytotal(~socp,p_design_bachelor)

p_design_1<-subset(p_design, sex=='1' & rac1p=='1')
p_design_2<-subset(p_design, sex=='1' & rac1p=='2')
p_design_5<-subset(p_design, sex=='1' & rac1p=='5')
p_design_6<-subset(p_design, sex=='1' & rac1p=='6')
p_design_7<-subset(p_design, sex=='1' & rac1p=='7')
p_design_8<-subset(p_design, sex=='1' & rac1p=='8')
p_design_9<-subset(p_design, sex=='1' & rac1p=='9')
p_design_10<-subset(p_design, sex=='1' & hisp=='Yes')

svytotal(~socp, p_design_1)
svytotal(~socp, p_design_2)
svytotal(~socp, p_design_5)
svytotal(~socp, p_design_6)
svytotal(~socp, p_design_7)
svytotal(~socp, p_design_8)
svytotal(~socp, p_design_9)
svytotal(~socp, p_design_10)

#########
###########
###########
###########
###########
#########

p_design_1<-subset(p_design, sex=='2' & rac1p=='1')
p_design_2<-subset(p_design, sex=='2' & rac1p=='2')
p_design_5<-subset(p_design, sex=='2' & rac1p=='5')
p_design_6<-subset(p_design, sex=='2' & rac1p=='6')
p_design_7<-subset(p_design, sex=='2' & rac1p=='7')
p_design_8<-subset(p_design, sex=='2' & rac1p=='8')
p_design_9<-subset(p_design, sex=='2' & rac1p=='9')
p_design_10<-subset(p_design, sex=='2' & hisp=='Yes')

svytotal(~socp, p_design_1)
svytotal(~socp, p_design_2)
svytotal(~socp, p_design_5)
svytotal(~socp, p_design_6)
svytotal(~socp, p_design_7)
svytotal(~socp, p_design_8)
svytotal(~socp, p_design_9)
svytotal(~socp, p_design_10)





svyby(~socp, ~rac1p, p_design_Male)
svytotal(~rac1p, p_design_Female)

svytotal(~sex, p_design)
svytotal(~hisp, p_design)
svytotal(~rac1p, p_design)

svytotal(~socp, p_design)

p_design_hispyes<-subset(p_design, hisp=='Yes')
p_design_hispno<-subset(p_design, hisp=='No')

svytotal(~socp, p_design_hispyes)
svytotal(~socp, p_design_hispno)
svytotal(~naicsp, p_design_hispyes)
svytotal(~naicsp, p_design_hispno)

p_design_white<-subset(p_design, rac1p=='1')
p_design_notWhite<-subset(p_design, rac1p!='1')

svytotal(~socp, p_design_white)
svytotal(~socp, p_design_notWhite)
svytotal(~naicsp, p_design_white)
svytotal(~naicsp, p_design_notWhite)

p_design_male<-subset(p_design, sex=='1')
p_design_female<-subset(p_design, sex=='2')

svytotal(~socp, p_design_male)
svytotal(~socp, p_design_female)
svytotal(~naicsp, p_design_male)
svytotal(~naicsp, p_design_female)

p_design_nonHispWhiteMale<-subset(p_design, sex=='1' & hisp=='No' & rac1p=='1')
p_design_womenOfColor<-subset(p_design, sex=='2' & hisp=='Yes' | rac1p!='1')

svytotal(~socp, p_design_nonHispWhiteMale)
svytotal(~socp, p_design_womenOfColor)
svytotal(~naicsp, p_design_nonHispWhiteMale)
svytotal(~naicsp, p_design_womenOfColor)

svytotal(~sex, p_design)
