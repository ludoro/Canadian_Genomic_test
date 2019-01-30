library(ggplot2)

#I take the input from the .tsv file, it is a 15488x5 matrix 
input = read.table(file = 'SCONES_test.tsv', sep = '\t', header = TRUE)

#I do the ratio element by element between last and second to last column
ratio = input[,5] / input[,4]

#I realize that the ratio may be negative as well, so I take the absolute value in order to avoid problems of existence
logratio = log(abs(ratio))


vector = data.frame(x = input[,2], y = logratio)

# At first I tried using the basic plot function, but the result was terrible because there are way too many points. 
# I found the library ggplot which seems really mainstream. I have a lot of alternatives:

# Plotting all the points with with very high transparency 
ggplot(vector, aes(x, y)) +
  geom_point(alpha = 0.04)

# Hexagonal binning, which seems appropriate because I have a lot of points. 
ggplot(vector,aes(x=x,y=y)) + stat_binhex()


# Density heatmap ( I like this a lot. )
ggplot(vector, aes(x, y)) +
  stat_density_2d(aes(fill = ..density..), geom = 'raster', contour = FALSE) +       
  scale_fill_viridis_c() +
  coord_cartesian(expand = FALSE) +
  geom_point(shape = '.', col = 'white')
