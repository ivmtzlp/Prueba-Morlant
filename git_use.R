
#ejemplo git R


library(usethis)
library(gitcreds)

#acceder a la cuenta git
use_git_config(user.name= "ivmtzlp", user.email="soylivo@gmail.com")


#set un branch de git
git_default_branch_configure()

#creando token
create_github_token()



gitcreds_get()

usethis::gh_token_help()

usethis::git_sitrep()

gh::gh_whoami()

#definior como la ruta de github
credentials::set_github_pat()


setwd("C:/Users/ivans/Desktop/Trab/Git")

for(i in 1:5){
  print(5+i)}
