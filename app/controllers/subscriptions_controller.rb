class SubscriptionsController < ApplicationController
  include ApplicationHelper
  before_action :set_event
  before_action :set_subscription, only: %i[destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user if current_user.present?
    
    if @new_subscription.save
      redirect_to @event, notice: t('controllers.subscriptions.created')
    else
      render "events/show"
    end
  end

  def destroy
    msg = { notice: t('controllers.subscriptions.destroyed') }
    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      msg = { notice: t('controllers.subscriptions.error') }
    end
    redirect_to @event, msg
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_name, :user_email)
  end
end
