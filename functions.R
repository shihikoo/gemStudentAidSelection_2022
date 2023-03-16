clean_student_df2022 <- function(df2022){
  df2022 <- df2022[!is.na(df2022$Degree),] 
  df2022[is.na(df2022)] = ''
  df2022[is.null(df2022)] = ''
  df2022[df2022 == 'null'] = ''
  
  
  df2022$Name = paste(df2022$F_Name, df2022$Mi_Name, df2022$Fa_Name)
  
  df2022$Gender <- tolower(df2022$Gender)
  return(df2022)
  }

selectionRun <- function(x) {
  
  return(runif(1,min=0.5*(x==0),max=1)) 
}
