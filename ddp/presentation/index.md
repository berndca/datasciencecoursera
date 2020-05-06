---
title       : Reproducible Pitch
subtitle    : Course Project
author      : Bernd Meyer
job         : 
framework   : shower        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {selfcontained, standalone, draft}
knit        : slidify::knit2slides
---

## Reproducible Pitch
### Bernd Meyer
#### May 6 2020

---

## My Shiny App 

- My app "Adding and Deleting Points" fits a linear model mpg ~ wt for the mtcars dataset.
- It allows the user to uses the brush function to delete and add points in the scatter plot.
- Each point a represents a observation. Deleted points are excluded from the model data.
- The coefficients for the linear model are being updated after any changes to the points.

---
## Model

- The model is lm(mpg ~ wt, data = mtcars)
- Below are the models coefficients with the full mtcars dataset. 

```r
summary(lm(mpg ~ wt, data = mtcars))$coef
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 37.285126   1.877627 19.857575 8.241799e-19
## wt          -5.344472   0.559101 -9.559044 1.293959e-10
```

---

## Plot Code


```r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) + geom_point() +
    geom_smooth(method = lm, 
                fullrange = TRUE, color = "black") +
    geom_point() + ggtitle("mtcars: lm(mpg ~ wt)") +
    coord_cartesian(xlim = c(1.5, 5.5), ylim = c(5,35))
```

---

## Plot 

![plot of chunk pressure](assets/fig/pressure-1.png)





