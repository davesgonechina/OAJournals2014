---
title       : 2014 OA Journal Data Analysis
subtitle    : Based on Walt Crawford's datasets
author      : Dave Lyons
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Open Access Journals

Open Access journals, where the author or institution pays for publication and the resulting content is made publicly available for free, are a new phenomenon in scholarly publishing that have met with some controversy. Librarian Walt Crawford recently made available the spreadsheets from his 2014 survey of open access journals. This app allows users to better examine that data.

--- .class #id 

## Major Facets of OA Journals

1. Subject Area
2. Quality
3. Article Processing Charges (APCs)

--- .class #id 

## The Data


```r
data <- getURL("https://raw.githubusercontent.com/davesgonechina/ShinyOA/master/doaj_journals.csv", ssl.verifypeer=0L, followlocation=1L)
doajcsv <- read.csv(text = data)
head(doajcsv)
```

```
##        Key X2014 X2013 X2012 X2011 Start Grade Pay.Free.Unk.NA     APC
## 1 AP436147    23    43    40    35  1998     A               P $1,316 
## 2 AP231538    12    22    21    23  1998     A               P   $995 
## 3 AP232147    11    21    23    20  2010     A               P   $995 
## 4 AP363487    14    36              2013     A               P   $980 
## 5 AP976187    69    93    89    97  2002     A               P   $975 
## 6 AP145698    92   145   102   100  2004     A               P   $975 
##   Note      Subject Group Area
## 1          Medicine     M    M
## 2           Biology     B    M
## 3        Technology   E&T    S
## 4         Chemistry   Sci    S
## 5      Anthropology    SS    H
## 6           Ecology   E&L    S
```


--- .class #id 

## Future Improvements

The following features could be added based on the available data:

1. Subject Area Drilldown
2. Paid or Free
3. The number of articles published is only available annually for a three-year period, so prediction models are difficult.

