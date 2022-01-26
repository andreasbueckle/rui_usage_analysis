source('pre_processing.R')
library(hash)

# number of logs per events
with_counts = ccf_reporter %>% 
  group_by(event_name, hostname) %>% 
  filter(hostname == 'hubmapconsortium.github.io', event_name!='webpage') %>% 
  tally() 
with_counts

ggplot(with_counts, aes(x=event_name, y=n, fill=hostname))+
  geom_bar(stat='identity', position = 'dodge')+
  xlab('User-generated events (until 1/25/22)')+
  ylab('Number of logged events')+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=15))+
  theme(axis.text.y = element_text(size=15))+
  theme(legend.position="bottom" )

# organs viewed

supported_organs = c("brain","heart","kidney","liver","bone_marrow","blood","large_intestine","lung", "lymph_nodes","skin","spleen","thymus","vasculature","eye","fallopian_tube","knee","lymph_vasculature","pancreas","peripheral_nervous_system","prostate","ovary","small_intestine","ureter","urinary bladder","uterus","blood", "blood_vasculature")
ccf_reporter$page_location

supported_organs %in% ccf_reporter$page_location

"netlify" %in% ccf_reporter$page_location




'hubmapconsortium.github.io' %in% ccf_reporter$hostname



  
apply(ccf_reporter$page_location, 1, function(supported_organs) any(supported_organs %in% "Matt")) 

organs = ccf_reporter %>% 
  select(page_location)
organs

organs %>% unique() %>% view()





lst_A <- supported_organs
lst_B = ccf_reporter$page_location

Pattern = paste(lst_A, collapse="|")
grepl(Pattern, lst_B)

library(data.table)
DT_result <- data.table(lst_B, result=grepl(Pattern, lst_B))
DT_result

str_detect(DT_result$lst_B,'TET|RNR')





str <- "Hello"
chars <- "ll"


grepl(chars, str, fixed = TRUE)

library(hash)
## hash-2.2.6 provided by Decision Patterns

h <- hash() 
for(i in 1:length(supported_organs)){
  print(supported_organs[i])
  h[supported_organs[i]] = 0
}
h

counter = 0
for(i in keys(h)){
  # print(i)
  # print(i)
  for (j in ccf_reporter$page_location){
    # print(j)
    if(grepl(i, j, fixed = TRUE)){
      counter = counter + 1
      h[[i]] = h[[i]] + 1
    }
    
    # if(grepl(i, j, fixed = TRUE)){print("got one!")}
    }
}
counter
h

result = tibble(.rows = length(keys(h)))
result$organ = keys(h)
result$counts = values(h)
result

ggplot(result, aes(x=organ, y=counts))+
  geom_bar(stat='identity')+
  xlab('Organs in page_location query string')+
  ylab('Number of logged page_locations per organ')+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=15))+
  theme(axis.text.y = element_text(size=15))+
  theme(legend.position="bottom" )

# <hash> containing 26 key-value pair(s).
# blood : 0
# blood_vasculature : 0
# bone_marrow : 1502
# brain : 1094
# eye : 0
# fallopian_tube : 0
# heart : 1103
# kidney : 1208
# knee : 0
# large_intestine : 571
# liver : 0
# lung : 754
# lymph_nodes : 799
# lymph_vasculature : 0
# ovary : 0
# pancreas : 0
# peripheral_nervous_system : 0
# prostate : 0
# skin : 785
# small_intestine : 0
# spleen : 731
# thymus : 622
# ureter : 0
# urinary bladder : 0
# uterus : 0
# vasculature : 688