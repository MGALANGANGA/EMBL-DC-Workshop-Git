#1. define ggplot object
# plt <- ggplot(data=<data.frame>, mapping = <aestethics>)
# x aestheics
# y aesthetics
# color aesthetics
# shape aesthetics
# ...

plt <- ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length))

plt
str(plt)


# Add geometry layer(s)
# geometry functions have predictable names
#geom_{point, line, bar, histogram, violin, hex, ...}
plt +
  geom_point()

plt +
  geom_point() +
  ggtitle("My first plot!")

plt <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + geom_point()

plt +
  ggtitle("Weight vs hindfoot_length") 

install.packages("hexbin")
library(hexbin)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_hex()


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1) #alpha is transparency


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue") 


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.25, aes(color = species_id))                


ggplot(
  data = surveys_complete,
  mapping = aes(
    x = weight,
    y= hindfoot_length,
    color = species_id
  )
) +
  geom_point(alpha = 0.25)


#Challenge: scatterplot weight vs species_id color by plot_type
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= weight,
    color = plot_type
  )
) +
  geom_point()


#Boxplots
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= weight,
    #color = plot_type
  )
) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.3, color = "salmon") #adding a little value for each x

#Change the order of the plots
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= weight)
) +
  geom_jitter(alpha = 0.3, color = "salmon") +
  geom_boxplot(outlier.shape = NA, fill = NA)

#Challenge: Produce a violin plot of weighT by species_id
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= weight)
) +
  geom_violin() +
  scale_y_log10() +
  ylab("Weight (log10)")

#Challenge: make a boxplot + jittered plot of hind_foot length by species_id. Boxplot should be in front of the dots and filled with white
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= hindfoot_length)
) +
  geom_jitter(alpha = 0.3, color = "firebrick") +
  geom_boxplot(outlier.shape = NA)

ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= hindfoot_length)
) +
  geom_jitter(alpha = 0.3, color = rgb (red=.3, green=.3, blue=.3)) +
  geom_boxplot(outlier.shape = NA)
  
# How to define colors
#"red", "green", "blue"
# rgb (red =.3, green = .3, blue = .3)
# # dedede hexadecimal code
  
ggplot(
  data = surveys_complete,
  mapping = aes(
    x = species_id,
    y= hindfoot_length)
) +
  geom_jitter(aes(color = factor(plot_id))) +
  geom_boxplot(outlier.shape = NA)

  

yearly_count <- surveys_complete %>% 
  count(year,genus)

ggplot(
  data = yearly_count,
  mapping = aes(
    x = year,
    y = n
  )
) +
  geom_line()

ggplot(
  data = yearly_count,
  mapping = aes(
    x = year,
    y = n,
    color = genus
  )
) +
  geom_line()

ggplot(
  data = yearly_count,
  mapping = aes(
    x = year,
    y = n,
    group = genus
  )
) +
  geom_line()

ggplot(
  data = yearly_count,
  mapping = aes(
    x = year,
    y = n,
    shape = genus,
    group = genus
  )
) +
  geom_line() +
  geom_point()

yearly_count %>% 
  ggplot(mapping = aes (x = year, y = n, color = genus)) +
  geom_line()

yearly_count_graph <- surveys_complete %>% 
  count(year, genus) %>% 
  ggplot(mapping = aes(x = year, y = n, color = genus)) +
  geom_line()

#Faceting
ggplot(
  data = yearly_count,
  mapping = aes(
    x = year,
    y = n)) +
    geom_line() +
    facet_wrap(facets = vars(genus))

surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(
    mapping = aes(
      x = year,
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(
    mapping = aes(
      x = year,
      y = n,
      color = sex)) +
  geom_line() +
  facet_grid(
    rows = vars(sex),
    cols = vars(genus))

surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(
    mapping = aes(
      x = year,
      y = n,
      color = sex)) +
  geom_line() +
  facet_grid(
    cols = vars(genus))

plt <- surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(
    mapping = aes(
      x = year,
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  theme_bw(base_size = 18)

ggsave(filename = "data/plot.pdf",
       plot = plt,
       width = 20,
       height = 20)

plt <- surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(
    mapping = aes(
      x = year,
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  xlab ("Year of observation") +
  ylab ("Number of individuals")+
  ggtitle ("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom",
    aspect.ratio = 1,
    axis.text.x = element_text(
      angle=45,
      hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank()
  )
plt

#There is a useful cheat sheet for this in: https://ggplot2.tidyverse.org/reference/