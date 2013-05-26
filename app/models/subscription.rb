class Subscription < ActiveRecord::Base
  has_many :tweets

  before_validation :determine_type

  private
    def determine_type
      if self.name.first == '@'
        self.type = 'TwiUser'
      else
        self.name = '#' + self.name if self.name.first != '#'
        self.type = 'Hashtag'
      end
    end
end
