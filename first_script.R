# x <- c(4, "a", TRUE)
# print(class(x))

x <- 1:3
y <- 4:6
m = cbind(x, y)
print(dim(m))

l <- list(2, "a", "b", TRUE)
print(l[[2]])

x <- 1:4
y <- 2:3

s <- x+y
print(s)

x <- c(3, 5, 1, 10, 12, 6)
x[x<6] <- 0
print(x)

df = read.csv("hw1_data.csv")
print("first two rows:")
df[1:2,]
print("last two rows:")
df[152:153,]

print("Ozone[47]:")
print(df$Ozone[47])

print("Missing Ozone values:")
print(sum(is.na(df$Ozone)))

print("Mean of vaid Ozone values:")
print(mean(df$Ozone[!is.na(df$Ozone)]))
  
high_ozon_temp <- df$Ozone > 31 & df$Temp > 90 & !is.na(df$Ozone) & !is.na(df$Temp)
high_solar <- df$Solar.R[high_ozon_temp]
# mean_high_solar <- mean(high_solar[!is.na(high_solar)])

temp_june <- mean(df$Temp[!is.na(df$Temp) & df$Month == 6])

max_ozone_may <- max(df$Ozone[!is.na(df$Ozone) & df$Month == 5])

