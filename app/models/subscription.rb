class Subscription < ActiveRecord::Base
  has_many :tweets
end
