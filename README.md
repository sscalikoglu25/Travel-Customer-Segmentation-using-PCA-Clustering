
# Travel Customer Segmentation using PCA & Clustering

## Project Overview
This project analyzes user-generated travel ratings to identify distinct customer segments and inform targeted marketing strategies for a U.S.-based travel company, Travelbiz. Using dimensionality reduction and clustering techniques, the analysis uncovers behavioral patterns in how users rate European travel experiences and translates these insights into actionable business recommendations.

## Contributors Serhat Calikoglu, Connor Holland, Kathryn McCarthy, Posy Olivetti
## Objective
The goal of this project is to:
- Identify customer segments based on travel preferences
- Understand relationships between destination attributes
- Develop targeted travel packages and marketing strategies
- Support data-driven decision-making for tourism product design

## Dataset
- Source: Google Reviews (2018)
- Observations: 5,456 users
- Features: 25 travel-related rating categories (scale: 0–5)
- Note: Ratings of 0 were kept

## Methodology

### Data Preprocessing & EDA
- Handled missing/zero values
- Standardized features
- Explored distributions and correlations
- Identified patterns across travel preferences

### Principal Component Analysis (PCA)
- Reduced dimensionality of 25 variables
- Identified key latent factors driving traveler preferences
- Interpreted component loadings to understand attribute groupings

### Clustering
- Applied K-Means clustering
- Determined optimal number of clusters using:
  - Elbow Method
  - Silhouette Score
- Profiled each segment based on travel behavior

## Key Insights
- Distinct traveler segments emerged (e.g., Urban Traveler, Wellness & Lifestyle Seeker, Nature and Cultural Enthusiast, Local Explorer)
- Strong relationships observed between certain travel attributes
- PCA revealed underlying preference dimensions such as:
  - Cultural and Nature
  - Social and Urban
  - Indoor and Service-Oriented

## Business Recommendations

Based on the identified customer segments, we recommended developing targeted travel packages tailored to distinct traveler preferences:

### 1. The Urban Traveler Package (Social & Urban Traveler)
**Target Audience:** Young professionals, city explorers, food enthusiasts  

**Key Recommendations:**
- Partner with local restaurants and bars to offer discounts, food tours, and wine tastings  
- Collaborate with zoos and museums to provide discounted entry and promote seasonal exhibits  
- Offer public transportation packages to improve accessibility and convenience within cities  

---

### 2. The Wellness & Relaxation Package (Wellness & Lifestyle Seeker)
**Target Audience:** Wellness enthusiasts, travelers seeking restorative experiences  

**Key Recommendations:**
- Highlight resorts with spas, pools, and fitness centers  
- Offer curated coffee and bakery walking tours featuring local favorites and scenic gardens  
- Provide a ClassPass-style fitness package with access to gyms and classes (yoga, pilates, bootcamp, swimming)  
- Include wellness services such as massages, facials, and spa treatments  

---

### 3. The Culture & Nature Explorer Package (Outdoor & Cultural Traveler)
**Target Audience:** Outdoor enthusiasts, history and culture-focused travelers  

**Key Recommendations:**
- Partner with local theaters to offer discounted tickets to plays and musicals  
- Provide guided tours and discounted access to parks, museums, monuments, churches, gardens, and scenic viewpoints  
- Offer beach day packages including chair and towel rentals  
- Include experiential activities such as surfing lessons  

---

### 4. The Local Immersion Package (Local Explorer)
**Target Audience:** Travelers seeking authentic, locally curated experiences  

**Key Recommendations:**
- Promote boutique hotels that provide a unique, local experience over chain accommodations  
- Offer curated food tours (e.g., pizza, burger crawls) featuring multiple local eateries  
- Partner with local art galleries to provide discounted entry and promote exhibitions 

### Marketing & Targeting
- Use digital platforms aligned with each segment’s behavior
- Personalize messaging based on travel preferences
- Leverage data-driven targeting to improve engagement

## Tools & Technologies
- R (tidyverse, cluister, caret, fatocoextra, GGally
- Data Visualization (corrplot, plotly)
