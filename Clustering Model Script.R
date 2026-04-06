
#Serhat Calikoglu
#Connor Holland
#Kathryn McCarthy
#Posy Olivetti


## Basically, we are trying to cater packages based on what different clusters of travelers are interested in
## For example, some might have really high ratings for food so their trips should be catered to that while others may be more interested in sightseeing

## My initial inclination would be to throw out all of the zeros becuase we really don't know what they mean. Will need to look at data first
## Also a 0 could mean they aren't interested in that type of activity

## Load necessary packages
#Load the packages
library(tidyverse)
library(cluster)
library(factoextra)
library(caret)
library(readxl)

## Load in the data
data <- read_excel("Travel_Review.xlsx")

# set random seed for reproducibility
set.seed(51515)

## View the structure of the data
str(data) ## UserID is the unique identifier (irrelevant) and the rest are numerics

## Check for missing values
colSums(is.na(data))

## Only one missing value, so it can be removed with almost no effect
which(is.na(data$Gardens))
data <- data[-1348,]

## Confirm missing value removed
colSums(is.na(data))

## Remove UserID and standardize the data
standardize <- preProcess(
  data[,2:25],
  method = c("center", "scale")
  )

data_standardized <- predict(standardize, data[, 2:25])

## Find the optimal number of clusters
# Elbow method
fviz_nbclust(data_standardized, kmeans, k.max=20, nstart=25, method="wss")
  # 4-6 is the ideal number of clusters

# Gap Statistic method
fviz_nbclust(data_standardized, kmeans, k.max=20, nstart=25, method="gap_stat",
             nboot=10)
  # 4 is the optimal number of clusters

## We will use XX clusters moving forward as wss and the gap statistic showed that this was the optimal number.

## -----------------------------K-mean clustering-----------------------------

## Perform k-means clustering
k_means <- kmeans(data_standardized, centers = 4  , nstart = 25)
      ## i tried 5,6,7,17 as well and the cluster silhouette plots didnt look any better

## Visualize the clusters using principal components
fviz_cluster(k_means, data=data_standardized) # Creates well separated clusters

## Visualize the silhouettes of k-means cluster
silh <- silhouette(k_means$cluster, dist(data_standardized)) # clusters are of similar size
fviz_silhouette(silh) # few negative values

# Attach cluster membership info to the original data and compare variable averages of each group
data_clust <- cbind(data, cluster = k_means$cluster)

head(data_clust) 

## Profile clusters taking mean of the numerical variables
aggregate(data_clust[,2:25], 
          by=list(data_clust$cluster), 
          mean)

## Process reproduces cluster centers when done on standardized data
aggregate(data_standardized, by = list(k_means$cluster), mean)

k_means$centers

# Visualize with ggplot
aggregate(
  data_clust[,2:25], 
  by = list(data_clust$cluster), 
  mean
) |>
  pivot_longer(
    cols = -1,
    names_to = "feature"
  ) |>
  group_by(feature) |>
  mutate(
    value = (value - mean(value)) / sd(value)  # Standardize for better comparison
  ) |>
  ungroup() |>
  ggplot(aes(x = feature, y = value, fill = factor(Group.1))) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~Group.1) + 
  theme_minimal() + 
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    legend.position = "none"
  ) +
  labs(
    title = "Cluster Profiles for K-Means",
    x = "Feature",
    y = "Standardized Mean Value"
  )

## Results
  # This does seem to prodcut some fairly distinct groupings
    # Group 1 is focused on leisure and likely has a higher budget. They like shopping, restaurants, and use
      # lots of local services to make their stay relaxing. They also enjoy nightlife.
    # Group 2 likes balance. They like going to historic sites like chruches and monuments but they also
      # want to spend time on the beach, enjoying nightlife, taking a swim, or trekking to viewpoints. Overall
      # though, they really aren't that interested in food. They focus on experiences.
    # Group 3 seems to be very focused on seeing the sights and experiencing the culture of cities
      # with high ratings for things like theatres, viewpoints, museums, monuments, parks, and beaches.
      # They have lower ratings on things like hotels, food, and nightlife. This might suggest
      # that they are more budget conscious and like to focus on the things only unique to their destination.
    # Group 4 focuses on a more local experience. They stay away from touristy sites like museums, churches,
      # and monuments. Instead, they focus on local gems like art galleries, pizza shops, and juice bars. They 
      # Prefer the quaint hotel to the big resort.

## -----------------------------K-medoid clustering-----------------------------

## Perform k-medoid clustering
k_medoid <- pam(data_standardized, 4, nstart = 25)

## Visualize the clusters using principal components
fviz_cluster(k_medoid, data=data_standardized)

## Visualize the silhouettes of k-means cluster
fviz_nbclust(data_standardized, cluster::pam, k.max=10, nstart=25, method="silhouette")
fviz_silhouette(silh) # Few negative values

# Attach cluster membership info to the original data and compare variable averages of each group
data_clust_medoid <- cbind(data, cluster = k_medoid$cluster)

head(data_clust_medoid) 

## Profile clusters taking mean of the numerical variables
aggregate(data_clust_medoid[,2:25], 
          by=list(data_clust_medoid$cluster), 
          mean)

## process reproduces cluster centers when done on standardized data
aggregate(data_standardized, by = list(k_medoid$cluster), mean)

k_medoid$centers

# Visualize with ggplot
aggregate(
  data_clust_medoid[,2:25], 
  by = list(data_clust_medoid$cluster), 
  mean
) |>
  pivot_longer(
    cols = -1,
    names_to = "feature"
  ) |>
  group_by(feature) |>
  mutate(
    value = (value - mean(value)) / sd(value)  # Standardize for better comparison
  ) |>
  ungroup() |>
  ggplot(aes(x = feature, y = value, fill = factor(Group.1))) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~Group.1) + 
  theme_minimal() + 
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    legend.position = "none"
  ) +
  labs(
    title = "Cluster Profiles for K-Medoids",
    x = "Feature",
    y = "Standardized Mean Value"
  )

## Results - This batch tells a slightly different story
  # Group 1 is focused more on leisure activities, enjoying things like going to the beach,
    # visiting the mall, strolling museums and parks, and attending the theater. They are also
    # far more interested in staying in a hotel and the amenities they provide than other lodging.
  # Group 2 is here to go malls, local services, pubs, zoos, restaurants. Can't really find a pattern here. 
  # Group 3 is here to see the sits and not much else. They don't want to waste time partying or shopping.
    # They prefer to see beaches, cafes, churches, gardens, monuments, and viewpoints.
  # Group 4 prefers to live like locals. They prefer art galleries and local cafes to crowded monuments, museums,
    # zoos, and restaurants. They also would rather stay in local lodging to big resort focused. 











## Figure out how groups overlap across different methods