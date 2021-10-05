source('pre_processing.R')


with_counts = rui_all %>% group_by(event_name, user_pseudo_id, hostname) %>%  tally() 
with_counts

remove_webpage = with_counts[with_counts$event_name != 'webpage', ]  

ggplot(remove_webpage, aes(x=event_name, y=n, fill=hostname))+
  geom_bar(stat='identity', position = 'dodge')+
  xlab('User-generated event')+
  ylab('Number of loggedn events')+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=15))+
  theme(axis.text.y = element_text(size=15))+
  theme(legend.position="bottom" )+ 
  scale_fill_discrete(name = "RUI version", labels = c("Standalone", "Ingest Portal"))+
  scale_fill_brewer(palette="Set1")

