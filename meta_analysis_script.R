ex1_data <- read_csv("meta_data_ex1.csv")

ex1_data <- read_csv("meta_data_ex1.csv")

glimpse(ex1_data)

ex1_data

library(metaPsychometric)
?metaPsychometric

ex1_results <- meta_bare_bones(ex1_data)
ex1_results
#prints the results in the console

#a credibility interval is trying to say, what is the range of population correlations that could vary due to moderators?
#i.e. lowest possible pop. cor, highest pop.cor
#typically use an 80% credibility interval
#unrelated to CI's
#changes if you're dealing with moderator correlations (i.e. men vs women)

#OUTPUT
#total participants was about 500 000
#average r was .30
#in this case there's one pop. cor of .30
#the variability observed was .002 -> variance of the 1000 studies 
#var_exp <- variability you'd expect due to random sampling (the same, because David made up the data)
#if per_error was less than 75%, you'd assume there's moderators (but it's 101, so there's no moderators)
#LL and UL are the CI's (.298, .303) -> very narrow CI
# credibility interval goes from .301 to .301 -> suggests no moderators

meta_plot_funnel(ex1_results)
#shows the plot
#every dot is a study (1000 studies)
#high sample sizes cluster around the true pop. cor of .30, and spread more when the SS is small
#if we know the pop. cor, then we can draw the funnel lines based on sampling theory (dorky stuff)

meta_plot_funnel(ex1_results, show_null_dist = TRUE)
#shows what it would look like if the true pop cor was 0 - the dots in that dist would be nonsignificant

#now we're doing the exact same thing again with example 2 data
#EXAMPLE 2 DATA

ex2_data <- read_csv("meta_data_ex2.csv")
ex2_results <- meta_bare_bones(ex2_data)
meta_plot_funnel(ex2_results)
ex2_results
#we only have 30 studies in this example
#r bar is .289, the truth is 30
# percent error is over 75, no moderators
# LL is .275, UL is .289
meta_plot_forest(ex2_results)
#gives us all 30 studies with CI's, and the bottom one is the meta analytic CI estimate


#EXAMPLE 3, a world with moderators
ex3_data <- read_csv("meta_data_ex3.csv")
ex3_results <- meta_bare_bones(ex3_data)
ex3_results
#20 conducted in canada, 20 in US
meta_plot_funnel(ex3_results)
#percent error is 12, less than 75, suggests moderators!
#not sure the CI will tell me much because there's moderators
#more than one population correlation
#credibility interval goes from .26 to .52 --> we don't know what causes this
#a lot of the dots are outside the 95% --> assuming there's a single pop cor, and that it's .395, 95% of all values should fit in this funnel
meta_plot_forest(ex3_results)
#the first 20 studies hardly overlap with the meta analytic mean, the second 20 studies do
# looks like the first 20 are underestimates, and the second 20 are overestimates
# so we're going to do subgroup analyses to see if canada and US are different

ex3_canada <- ex3_data %>% filter(country=="Canada")
ex3_usa <- ex3_data %>% filter(country=="United States")
#filters out US and canada

meta_bare_bones(ex3_canada)
#mean for canada is .28
#credibility interval is .28 to .28
#no moderators
#percent error is 173
meta_bare_bones(ex3_usa)
#meta analytic correlation is .49
#goes from .47 to .50
#fair amount of certainty there's not moderators
#percent error is 88

#we can see there's no moderators when they're separated
# profound differences in what's happening in canada vs us

ex3_results_canada <- meta_bare_bones(ex3_canada)
ex3_results_usa <- meta_bare_bones(ex3_usa)

meta_plot_forest(ex3_results_usa)
meta_plot_forest(ex3_results_canada)
#still a narrow CI at the meta analysis level
#our friends are big N and lots of studies








