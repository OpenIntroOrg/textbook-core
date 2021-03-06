library(xtable)
library(openintro)
d <- loans_full_schema
d$past_bankr <- (d$public_record_bankrupt > 0) + 0



myPDF("intRateVsPastBankrScatter.pdf", 4.2, 4,
      mar = c(3.7, 3.7, 0, 0.5),
      mgp = c(2.5,0.55,0))
plot(d$past_bankr, d$interest_rate,
     xlim = c(-0.15, 1.15),
     axes = FALSE,
     type = "n",
     xlab = "",
     ylab = "Interest Rate")
at <- seq(0, 30, 5)
abline(h = at, col = COL[7, 3])
points(d$past_bankr, # + runif(nrow(d), -0.05, 0.05),
    d$interest_rate, # + rnorm(nrow(d), sd = 0.5),
    col = COL[1, 4],
    pch = 19,
    cex = 0.7)
AxisInPercent(2, at)
par(mgp = c(2.5, 1.55, 0))
axis(1, at = 0:1, labels = c("0\n(no)", "1\n(yes)"))
par(mgp = c(2.5, 0.55, 0))
mtext("Any Past Bankruptcy", 1, 2.6)
m <- lm(interest_rate ~ past_bankr, data = d)
abline(m, col = COL[5], lwd = 1.5)
dev.off()

summary(m)
xtable(m)
