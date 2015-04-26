# Github 
# Application: sunApps
# Client ID: 5a1e0c1d3d3cd166ecc3
# Client Secret: c2e14af3833cb1641683ba6f2d41876720567998
# Token: a241e5dc6a5a9618a6750fc61561cc383071ae85

# Approach 1:
library('jsonlite')

hadley_orgs <- fromJSON("https://api.github.com/users/hadley/orgs")
hadley_repos <- fromJSON("https://api.github.com/users/hadley/repos")
leek_repos <- fromJSON("https://api.github.com/users/jtleek/repos")
leek_repos[leek_repos$name=="datasharing","created_at"] # 2013-11-07T13:25:07Z

# Approach 2:
library(httr)
library(jsonlite)
library(httpuv)

# Authenticate (using OAuth)
client_id <- "5a1e0c1d3d3cd166ecc3"
client_secret <- "638e45375e101310ec670bd48c27aa5d0d3513fb"

authorize <- oauth_endpoints("github")$authorize
accessToken <- oauth_endpoints("github")$access

sunApp <- oauth_app("github", client_id, secret=client_secret)
myToken <- oauth2.0_token(oauth_endpoints("github"), app=sunApp)

# Get contents (using URL)
leekURL <- "https://api.github.com/users/jtleek/repos"
leekRepos <- GET(leekURL, config(token=myToken))
leekJSON <- content(leekRepos)
leekData <- jsonlite::fromJSON(toJSON(leekJSON))

# Parse contents (for answer)
leekData[leekData$name=="datasharing","created_at"][[1]]
