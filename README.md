# Tweet Board

This is an example of **Rails-as-a-frontend** app, which means you have a separate source to feed data to database, instead of manipulate all data from Rails models only. In this example I use a Twitter crawler as data source.

## Usage

You need to [register a Twitter application](https://dev.twitter.com/apps/new) first.

Start Rails server:

    rails s
    
And the crawler:

    bin/tweet_crawler.rb consumer_key consumer_secret oauth_token oauth_secret
    