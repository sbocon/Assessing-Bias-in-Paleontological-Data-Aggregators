#Thank you for downloading my code!
library(divDyn)
#I recommend downloading your data as a .csv from the PBDB
#To work with my code, name this file "base_data.csv"
dat <- read.csv("base_data.csv", header=TRUE, stringsAsFactors=FALSE)
dat <- dat[dat$genus!="", ]
dat <- dat[dat$class!="", ]
dat <- dat[dat$order!="", ]
dat <- dat[dat$family!="", ]
need<-c("collection_no","accepted_name","accepted_rank", 
        "identified_name","identified_rank","early_interval", 
        "late_interval", "max_ma","min_ma","reference_no", 
        "phylum", "class", "order", "family",
        "genus")
dat <- dat[,need]
save(dat, file="base_data.RData")
data(stages)
data(tens)
data("keys")
data("stratkeys")
stgMin <- categorize(dat[,"early_interval"], keys$stgInt)
stgMax <- categorize(dat[ ,"late_interval"], keys$stgInt)
stgMin <- as.numeric(stgMin)
stgMax <- as.numeric(stgMax)
dat$stg <- rep(NA, nrow(dat))
stgCondition <- c(which(stgMax==stgMin),which(stgMax==-1))
dat$stg[stgCondition] <- stgMin[stgCondition]
load(url("https://github.com/divDyn/ddPhanero/raw/master/data/Stratigraphy/2018-08-31/cambStrat.RData"))
source("https://github.com/divDyn/ddPhanero/raw/master/scripts/strat/2018-08-31/cambProcess.R")
load(url("https://github.com/divDyn/ddPhanero/raw/master/data/Stratigraphy/2018-08-31/ordStrat.RData"))
source(
  "https://github.com/divDyn/ddPhanero/raw/master/scripts/strat/2019-05-31/ordProcess.R")
fl <- fadlad(dat, bin="stg", tax="genus")
dat$mid <- stages$mid[dat$stg]
#Okay, your data should be formatted
#To create a range plot through Phanerozoic
tsplot(stages, boxes=c("short","system"), shading="short", xlim=4:93, boxes.col=c("col","systemCol"), labels.args=list(cex=0.5))
ranges(dat, tax="class", bin="mid", ranges.args=list(col=c("black")), labs=T,labels.args=list(cex=0.6), filt="orig", occs=T, group="class")
title(main="Ranges of taxon")
#Occurrence plot
samp <-binstat(dat, tax="class", bin="stg",
               coll="collection_no", ref="reference_no", indices=TRUE, duplicates=TRUE)
tsplot(stages, shading="series", boxes="sys", xlim=4:93, boxes.col=c("systemCol"), ylab="number of occurrences", ylim=c(0,3000))
lines(stages$mid[4:93], samp$occs[4:93])
title(main="Occurrences of taxon")
