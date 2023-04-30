library(tidyverse)
library(dplyr)
library(lme4)
library(devtools)

library(effects)

d_analysis <- read_csv("experiment_data.csv")


### Model predicting dark-more responses from spatial configuration,
#### color scale, background, and granularity
m1 <- glmer(response_darker ~ spatial_config * (color_scale_c1_factor + color_scale_c2_factor) *
            background_c * granularity_c + (1|subject_id),
            family = binomial, data=d_model, control=glmerControl(optimizer="nlminbwrap",optCtrl=list(maxfun=15e5)))
summary(m1)



######Tests against chance; 24 groups, holm-bonferroni corrected

# for each of 24 groups, subset the correct shift/granularity/colorscale/background
blshift_cont_spiral_white <- subset(d_analysis, 
                                    background=="white" & cluster=="spiral" & 
                                      granularity_c==1 & spatial_config==-1)
#then run a model predicting darker responses from the intercept
glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_spiral_white)
summary(m_blshift_cont_spiral_white)


blshift_cont_mono_white <- subset(d_analysis, 
                                    background=="white" & cluster=="mono" & 
                                      granularity_c==1 & spatial_config==-1)
m_blshift_cont_mono_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_mono_white)
summary(m_blshift_cont_mono_white)


blshift_cont_spiralbw_white <- subset(d_analysis, 
                                    background=="white" & cluster=="blackwhite" & 
                                      granularity_c==1 & spatial_config==-1)
m_blshift_cont_spiralbw_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_spiralbw_white)
summary(m_blshift_cont_spiralbw_white)


blshift_cont_spiral_black <- subset(d_analysis, 
                                    background=="black" & cluster=="spiral" & 
                                      granularity_c==1 & spatial_config==-1)
m_blshift_cont_spiral_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_spiral_black)
summary(m_blshift_cont_spiral_black)


blshift_cont_mono_black <- subset(d_analysis, 
                                  background=="black" & cluster=="mono" & 
                                    granularity_c==1 & spatial_config==-1)
m_blshift_cont_mono_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_mono_black)
summary(m_blshift_cont_mono_black)


blshift_cont_spiralbw_black <- subset(d_analysis, 
                                      background=="black" & cluster=="blackwhite" & 
                                        granularity_c==1 & spatial_config==-1)
m_blshift_cont_spiralbw_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_cont_spiralbw_black)
summary(m_blshift_cont_spiralbw_black)


unshift_cont_spiral_white <- subset(d_analysis, 
                                    background=="white" & cluster=="spiral" & 
                                      granularity_c==1 & spatial_config==1)
m_unshift_cont_spiral_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_spiral_white)
summary(m_unshift_cont_spiral_white)


unshift_cont_mono_white <- subset(d_analysis, 
                                  background=="white" & cluster=="mono" & 
                                    granularity_c==1 & spatial_config==1)
m_unshift_cont_mono_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_mono_white)
summary(m_unshift_cont_mono_white)


unshift_cont_spiralbw_white <- subset(d_analysis, 
                                      background=="white" & cluster=="blackwhite" & 
                                        granularity_c==1 & spatial_config==1)
m_unshift_cont_spiralbw_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_spiralbw_white)
summary(m_unshift_cont_spiralbw_white)


unshift_cont_spiral_black <- subset(d_analysis, 
                                    background=="black" & cluster=="spiral" & 
                                      granularity_c==1 & spatial_config==1)
m_unshift_cont_spiral_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_spiral_black)
summary(m_unshift_cont_spiral_black)


unshift_cont_mono_black <- subset(d_analysis, 
                                  background=="black" & cluster=="mono" & 
                                    granularity_c==1 & spatial_config==1)
m_unshift_cont_mono_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_mono_black)
summary(m_unshift_cont_mono_black)


unshift_cont_spiralbw_black <- subset(d_analysis, 
                                      background=="black" & cluster=="blackwhite" & 
                                        granularity_c==1 & spatial_config==1)
m_unshift_cont_spiralbw_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_cont_spiralbw_black)
summary(m_unshift_cont_spiralbw_black)


blshift_grid_spiral_white <- subset(d_analysis, 
                                    background=="white" & cluster=="spiral" & 
                                      granularity_c==-1 & spatial_config==-1)
m_blshift_grid_spiral_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_spiral_white)
summary(m_blshift_grid_spiral_white)


blshift_grid_mono_white <- subset(d_analysis, 
                                  background=="white" & cluster=="mono" & 
                                    granularity_c==-1 & spatial_config==-1)
m_blshift_grid_mono_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_mono_white)
summary(m_blshift_grid_mono_white)


blshift_grid_spiralbw_white <- subset(d_analysis, 
                                      background=="white" & cluster=="blackwhite" & 
                                        granularity_c==-1 & spatial_config==-1)
m_blshift_grid_spiralbw_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_spiralbw_white, 
                                       control=glmerControl(optimizer="bobyqa"))
summary(m_blshift_grid_spiralbw_white)


blshift_grid_spiral_black <- subset(d_analysis, 
                                    background=="black" & cluster=="spiral" & 
                                      granularity_c==-1 & spatial_config==-1)
m_blshift_grid_spiral_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_spiral_black)
summary(m_blshift_grid_spiral_black)


blshift_grid_mono_black <- subset(d_analysis, 
                                  background=="black" & cluster=="mono" & 
                                    granularity_c==-1 & spatial_config==-1)
m_blshift_grid_mono_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_mono_black)
summary(m_blshift_grid_mono_black)


blshift_grid_spiralbw_black <- subset(d_analysis, 
                                      background=="black" & cluster=="blackwhite" & 
                                        granularity_c==-1 & spatial_config==-1)
m_blshift_grid_spiralbw_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=blshift_grid_spiralbw_black)
summary(m_blshift_grid_spiralbw_black)


unshift_grid_spiral_white <- subset(d_analysis, 
                                    background=="white" & cluster=="spiral" & 
                                      granularity_c==-1 & spatial_config==1)
m_unshift_grid_spiral_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_spiral_white)
summary(m_unshift_grid_spiral_white)


unshift_grid_mono_white <- subset(d_analysis, 
                                  background=="white" & cluster=="mono" & 
                                    granularity_c==-1 & spatial_config==1)
m_unshift_grid_mono_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_mono_white)
summary(m_unshift_grid_mono_white)


unshift_grid_spiralbw_white <- subset(d_analysis, 
                                      background=="white" & cluster=="blackwhite" & 
                                        granularity_c==-1 & spatial_config==1)
m_unshift_grid_spiralbw_white <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_spiralbw_white)
summary(m_unshift_grid_spiralbw_white)

unshift_grid_spiral_black <- subset(d_analysis, 
                                    background=="black" & cluster=="spiral" & 
                                      granularity_c==-1 & spatial_config==1)
m_unshift_grid_spiral_black  <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_spiral_black)
summary(m_unshift_grid_spiral_black)


unshift_grid_mono_black <- subset(d_analysis, 
                                  background=="black" & cluster=="mono" & 
                                    granularity_c==-1 & spatial_config==1)
m_unshift_grid_mono_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_mono_black)
summary(m_unshift_grid_mono_black)


unshift_grid_spiralbw_black <- subset(d_analysis, 
                                      background=="black" & cluster=="blackwhite" & 
                                        granularity_c==-1 & spatial_config==1)
m_unshift_grid_spiralbw_black <- glmer(response_darker ~ 1 + (1|subject_id), family = binomial, data=unshift_grid_spiralbw_black)
summary(m_unshift_grid_spiralbw_black)



#create a data frame of all conditions (created above) and of p-values.
conditions <- c("blshift_cont_spiral_white", "blshift_cont_mono_white","blshift_cont_spiralbw_white",
                    "blshift_cont_spiral_black","blshift_cont_mono_black",
                    "blshift_cont_spiralbw_black","unshift_cont_spiral_white",
                    "unshift_cont_mono_white","unshift_cont_spiralbw_white",
                    "unshift_cont_spiral_black","unshift_cont_mono_black",
                    "unshift_cont_spiralbw_black","blshift_grid_spiral_white",
                    "blshift_grid_mono_white","blshift_grid_spiralbw_white",
                    "blshift_grid_spiral_black","blshift_grid_mono_black",
                    "blshift_grid_spiralbw_black","unshift_grid_spiral_white",
                    "unshift_grid_mono_white","unshift_grid_spiralbw_white",
                    "unshift_grid_spiral_black","unshift_grid_mono_black",
                    "unshift_grid_spiralbw_black")
p_values <- c(3.5e-11,7.25e-16,0.361,1.25e-10,4.93e-12,0.174,0.161,
              2.22e-05,1.21e-15,0.016,4.27e-11,1.03e-14,3.15e-10,4.19e-11,2e-16,
              2e-11,4.63e-11,2e-16,0.322,1.96e-05,6.67e-08,0.00183,6.95e-08,2e-16)
d_holm <- data.frame(conditions,p_values) # combine columns into 1 data frame
d_holm2 <- d_holm[order(d_holm$p_values),] # order p values least to greatest

# adjust p-values using holm-bonferroni 
p_adj <- p.adjust(d_holm2$p_values, method = "holm")

d_holm2$p_adj <- round(p_adj,4) # add holm-bonferroni output to original dataframe

