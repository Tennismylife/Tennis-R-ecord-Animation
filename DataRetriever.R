
Retrieve <- function(){
  
  stat <- unique(db[round == 'F' & tourney_level == 'G'])
  
  stat$year <- stringr::str_sub(stat$tourney_id, 0 ,4)
  
  tournaments <- unique(stat[, c('tourney_name', 'year', 'tourney_id')])
  
  tourneyandwinner <- unique(stat[, c('tourney_name', 'year', 'tourney_id', 'winner_name')])
  
  winners <- unique(stat[, c('winner_name')])
  
  tour <- dplyr::pull(tournaments, tourney_id)
  
  wins <- '0'
  
  stat2 <- NULL
  
  id <- '1'
  
  stat <- cbind(tour[1], id, winners, wins)
  names(stat)[1] <- "tourney_id"
  
  first <- head(tourneyandwinner[tourney_id == tour[1]], 1)
  winner <- first[,c("winner_name")]
  
  winner <- winner$winner_name
  
  print(winner)
  
  print(stat$wins[which(stat$winner_name == winner)])
  
  stat$wins[which(stat$winner_name == winner)] <- as.integer(stat$wins[which(stat$winner_name == winner)]) + 1
  
  stat2 <- rbind(stat2, stat)
  
  wins <- stat$wins
  
  for(i in 2:length(tour)){
    
    id <- i
    
    stat <- cbind(tour[i], id, winners, wins)
    names(stat)[1] <- "tourney_id"
    
    first <- head(tourneyandwinner[tourney_id == tour[i]], 1)
    winner <- first[,c("winner_name")]
    winner <- winner$winner_name
    print(winner)
    
    print(stat$wins[which(stat$winner_name == winner)])
    
    stat$wins[which(stat$winner_name == winner)] <- as.integer(stat$wins[which(stat$winner_name == winner)]) + 1
    
    stat2 <- rbind(stat2, stat)
    
    wins <- stat$wins
  }
  
  res <- db[tourney_level == 'G' & round == 'F']
  officialName <- unique(res[, c('tourney_id', 'tourney_name')])
  
  stat2 <- left_join(stat2, officialName, by = "tourney_id")     
  
  stat2 <- left_join(stat2, tourneyandwinner, by = "tourney_id")
  
  stat2$year <- paste0(stat2$tourney_name.x, " ", stat2$year)
  
  stat2$group_id <- stat2 %>% group_indices(year)
  
  stat2 <- stat2[, c('year', 'id', 'winner_name.x', 'wins')]
  
  names(stat2)[1] <- "tourney"
  names(stat2)[2] <- "id"
  names(stat2)[3] <- "winner_name"
  names(stat2)[4] <- "wins"
  
  M1000Roll <- stat2[, c('tourney', 'id', 'winner_name', 'wins')]
  
}