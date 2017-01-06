class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  # def create
  #   @subscription = Subscription.new(subscription_params)
  # 
  #   if @subscription.save
  #     redirect_to @subscription, notice: 'Subscription was successfully created.'
  #   else
  #     render :new
  #   end
  # end
  # 
  # def destroy
  #   @subscription.destroy
  #   redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.'
  # end

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    if current_user_can_edit?(@subscription)
      @subscription.destroy!
      message = { notice: I18n.t('controllers.subscriptions.destroyed') }
    else
      message = { alert: I18n.t('controllers.subscriptions.error') }
    end
    redirect_to @event, message
  end
  
  
  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @comment = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
