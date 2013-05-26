class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #noinspection RailsParamDefResolve
  protect_from_forgery :with => :exception

  before_filter :header_fields

  def header_fields
    @subscription = Subscription.new
  end
end
