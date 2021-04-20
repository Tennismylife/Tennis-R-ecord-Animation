Formatter <- function(M1000Roll){

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

}