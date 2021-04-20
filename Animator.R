library(gganimate)

animation <- function(M1000RollFormatted){
# Animation

anim <- ggplot(M1000RollFormatted, aes(rank, group = winner_name,
                                  fill = as.factor(winner_name), color = as.factor(winner_name))) +
  geom_tile(aes(y = wins/2,
                height = wins,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(winner_name, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=wins,label = value_lbl, hjust=0)) +
  geom_text(aes(x=0, y=0, label=paste0(tourney)), size=7, color = 'red') +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm")) +
  transition_states(id, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'ATP Masters 1000 record',
       caption  = "ATP Masters 1000 record | Data Source: Tennismylife")

# For GIF

animate(anim, nframes = 2000, fps = 20,  width = 720, height = 580, renderer = gifski_renderer("./Animation/gganim.gif")) 

# For MP4

animate(anim, 2000, fps = 20,  width = 720, height = 580, renderer = av_renderer()) -> for_mp4

anim_save("./Animation/animation.mp4", animation = for_mp4 )
}