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
    # render 'events/show', :alert => "You haz errors!"
    if current_user == @event.user
      render file: 'public/404.html', status: 404, formats: [:erb]
    else
      @new_subscription = @event.subscriptions.build(subscription_params)
      @new_subscription.user = current_user
      if @new_subscription.save
        # EventMailer.subscription(@event, @new_subscription).deliver
        EventMailer.subscription(@event, @new_subscription).deliver_now
        redirect_to @event, notice: t('.success')
      else
        render 'events/show', alert: t('.error')
      end
    end
  end

  def destroy
    message = { notice: t('.success') }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: t('.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
