This repository is a spin-off of the https://github.com/Tennismylife/Tennis-R-ecord-Tracker that we can consider as a 'Main'

In particular here we can find a pretty cool way to plot the data from TML Database as an animate gif (or mp4 if you prefer to)



- Main.R
- 
Collection of main functions


- Reader.R

This is a engine for reading the exclusive database with the ATP data from our repository

- Retrieve.R

You can select a tourney_level / category such as 'G' for Slams or 'M' for ATP Masters 1000. In this example is used the 'M'. The script will search all the ATP tournaments in this category and in a for cycle loop will increment a variable called 'wins' for the title winner. Preliminary we collect all the winners, since 1990, in order to avoid bug in the animator script.

Formatter.R

```
>> 
M1000Roll$wins <- as.double(M1000Roll$wins)
M1000Roll$id <- as.double(M1000Roll$id)

print(typeof(M1000Roll$wins))

M1000RollFormatted <- M1000Roll %>%
  group_by(tourney) %>%
  # The * 1 makes it possible to have non-integer ranks while sliding
  mutate(rank = rank(-wins, ties.method = "first"),
         value_lbl = paste0(" ",round(wins))) %>%
  group_by(winner_name) %>%
  filter(rank <=15) %>%
  ungroup()
```
'M1000Roll' alone isn't able to plot what we want to, so it's necessary format the data assigning a rank to the 'wins' and to selecting a subset (15 in this example). 

*Animator.R

Having M1000RollFormatted we can plot the data using the fantastic library 'ggplot'. This library is used for a static graph so it's necessary using another R library, 'gganimate'. All the graphs produced by ggplot will be saved in an animation called 'anim'


```
>> animate(anim, nframes = 2000, fps = 20,  width = 720, height = 580, renderer = gifski_renderer("gganim.gif")) 

``
We are ready for the gif. Using the gifski_renderer we convert the animation to gif and....that's all, folks! (there is already saved 'gganim.gif' as example)

If you prefer it's possibile also save the animation as an mp4 video 

```
>> animate(anim, 2000, fps = 20,  width = 720, height = 580, renderer = av_renderer()) -> for_mp4

anim_save("animation.mp4", animation = for_mp4 )
```

![Alt Text](https://github.com/Tennismylife/Tennis-R-ecord-Animation/blob/main/Animation/gganim.gif)
