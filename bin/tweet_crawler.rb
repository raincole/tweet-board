#!/usr/bin/env ruby

$LOAD_PATH << Dir.pwd
require 'debugger'
require 'twitter'
require 'active_record'
require 'app/models/subscription'
require 'app/models/hashtag'
require 'app/models/twi_user'
require 'app/models/tweet'

$ENV = ENV['RAILS_ENV'] || 'development'

if ARGV.size != 4
  puts 'Usage: bin/tweet_crawler.rb app_key app_secret oauth_token oauth_secret'
  exit
end

app_key = ARGV[0]
app_secret = ARGV[1]
oauth_token = ARGV[2]
oauth_secret = ARGV[3]

db_config = YAML.load_file('config/database.yml')[$ENV]
ActiveRecord::Base.establish_connection(db_config)

Twitter.configure do |config|
  config.consumer_key = app_key
  config.consumer_secret = app_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_secret
end

while true
  Subscription.all.each do |s|
    query = s.name

    puts "Search '#{query}'..."
    tweets = Twitter.search(query).results
    puts "Got #{tweets.size} items."

    old_tweet_count = s.tweets.count
    if old_tweet_count > 0
      newest_tweet_time = s.tweets.order('post_time DESC').limit(1).first.post_time
    end
    tweets.each do |t|
      if newest_tweet_time == nil || t.created_at > newest_tweet_time
        s.tweets.create(
            post_time: t.created_at,
            content: t.text,
            author_avatar: t.user.profile_image_url,
            author_name: t.user.name,
            author_screen_name: t.user.screen_name,
            twi_id: t.id,
        )
      end
    end

    puts "Created #{s.tweets.count - old_tweet_count} items."

    sleep 1
  end
end
