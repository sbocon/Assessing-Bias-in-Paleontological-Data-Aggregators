#Thank you for downloading my code!
library(divDyn)
library(tidyverse)
#iDigBio automatically downloads files as "occurrence.csv"
dat <- read.csv("occurrence.csv", header=TRUE, stringsAsFactors=FALSE)
dat <- dat[dat$dwc:class!="", ]
dat <- dat[dat$dwc:order!="", ]
dat <- dat[dat$dwc:earliestPeriodOrLowestSystem!="", ]
dat <- dat[dat$dwc:dwc:latestPeriodOrHighestSystem!="", ]
dat <- dat[dat$Family!="", ]
data(stages)
data(tens)
data("keys")
data("stratkeys")
#range plots
tsplot(stages, boxes=c("short","system"), shading="short", xlim=4:93, boxes.col=c("col","systemCol"), labels.args=list(cex=0.5))
ranges(dat, tax="dwc:class", bin="mid", ranges.args=list(col=c("black")), labs=T,labels.args=list(cex=0.6), filt="orig", occs=T, group="dwc:class")
title(main="Ranges of taxon")
#occurrence plot
tsplot(stages, shading="series", boxes="sys", xlim=4:93, boxes.col=c("systemCol"), ylab="number of occurrences", ylim=c(0,7000))
df <- dat %>%
  group_by(mid) %>%
  summarise(Occurrences = n())
lines(df$mid, df$Occurrences)
title(main="Occurrences of taxa")
