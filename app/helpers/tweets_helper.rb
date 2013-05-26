module TweetsHelper
  def twi_user_url(screen_name)
    screen_name.gsub!(/^@/, '')
    return "http://twitter.com/#{screen_name}"
  end
end
