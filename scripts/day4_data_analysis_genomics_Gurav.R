library(tidyverse)

raw_cts <- read_csv("data_rnaseq/counts_raw.csv")
trans_cts <- read_csv("data_rnaseq/counts_transformed.csv")
sample_info <- read_csv("data_rnaseq/sample_info.csv")
test_result <- read_csv("data_rnaseq/test_result.csv")

trans_cts_long <- trans_cts %>% 
  pivot_longer(names_to = "sample", values_to = "cts", cols = wt_0_r1:mut_180_r3) #or cols = -gene

trans_cts_long <- full_join(trans_cts_long, sample_info, by = "sample")

trans_cts_long %>% 
  ggplot(
    aes(x = cts)) +
  geom_freqpoly()

trans_cts_long %>% 
  ggplot(
    aes(x = cts, colour = replicate)) +
  geom_freqpoly()

trans_cts_long %>% 
  ggplot(
    aes(x = cts, colour = replicate)) +
  geom_freqpoly(binwidth = 1)

trans_cts_long %>% 
  ggplot(
    aes(x = cts, colour = replicate)) +
  geom_freqpoly(binwidth = 1) +
  facet_grid(rows = vars(strain), cols = vars(minute))


#Exercise
raw_cts_long <- raw_cts %>% 
  pivot_longer(names_to = "sample", values_to = "cts", cols = wt_0_r1:mut_180_r3)

raw_cts_long <- full_join(raw_cts_long, sample_info, by = "sample")

raw_cts_long %>% 
  ggplot(aes(x = cts, colour = replicate)) +
  geom_freqpoly() +
  facet_grid(rows = vars(strain), cols = vars(minute))

raw_cts_long %>% 
  ggplot(aes(x = cts, colour = replicate)) +
  geom_freqpoly() +
  facet_grid(rows = vars(strain), cols = vars(minute)) +
  scale_x_log10()

raw_cts_long %>% 
  ggplot(aes(x = log10(cts), colour = replicate)) +
  geom_freqpoly() +
  facet_grid(rows = vars(strain), cols = vars(minute))

log10(0)
log10(1)

raw_cts_long %>% 
  ggplot(aes(x = log10(cts+1), colour = replicate)) +
  geom_freqpoly() +
  facet_grid(rows = vars(strain), cols = vars(minute))

raw_cts_long %>% 
  ggplot(aes(x = log10(cts+1), colour = replicate)) +
  geom_freqpoly(binwidth = 1) +
  facet_grid(rows = vars(strain), cols = vars(minute))

# Instead of using freqpoly, lets try making a boxplot
raw_cts_long %>% 
  ggplot(aes(x = factor(minute), y = log10(cts+1), fill = strain)) +
  geom_boxplot() +
  facet_grid(cols = vars(replicate))

# Correlation between wt sample at T0 and T30
trans_cts
trans_cts_long

trans_cts %>% 
  ggplot(aes(x = wt_0_r1, y = wt_30_r1)) +
  geom_point()

trans_cts %>% 
  ggplot(aes(x = wt_0_r1, y = wt_30_r1)) +
  geom_point() +
  geom_abline(colour= "red")

trans_cts %>% 
  ggplot(aes(x = wt_0_r1, y = wt_0_r2)) +
  geom_point() +
  geom_abline(colour= "red")

#To look at the correlation of count data across all samples in our experiment
trans_cts_corr <- trans_cts %>% 
  select(-gene) %>% 
  cor(method = "spearman")


library(corrr)

rplot(trans_cts_corr)

rplot(trans_cts_corr) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Compare trans_cts and raw_cts
summary(raw_cts_long$cts)
summary(trans_cts_long$cts)


raw_cts %>% 
  ggplot(aes(x = wt_0_r1, y = wt_0_r2)) +
  geom_point()

raw_cts %>% 
  ggplot(aes(x = wt_0_r1 + 1, y = wt_0_r2 + 1)) +
  geom_point() +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2")

raw_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts = mean(cts), var_cts = var(cts)) %>% 
  ggplot(aes(x = mean_cts, y = var_cts)) +
  geom_point() +
  geom_abline(colour = "red") +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2")

trans_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts = mean(cts), var_cts = var(cts)) %>% 
  ggplot(aes(x = mean_cts, y = var_cts)) +
  geom_point()

trans_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts = mean(cts), var_cts = var(cts)) %>% 
  mutate(above_four = var_cts > 4) %>% 
  ggplot(aes(x = mean_cts, y = var_cts, colour = above_four)) +
  geom_point()
