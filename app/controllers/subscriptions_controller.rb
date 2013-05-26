class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.all.includes(:tweets)
  end

  def create
    @subscription = Subscription.create!(subscription_params)

    redirect_to subscriptions_path
  end

  private

    def subscription_params
      params.require(:subscription).permit(:name)
    end
end
