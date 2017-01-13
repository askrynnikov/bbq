class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  # POST /comments
  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@event, @new_comment)
      redirect_to @event, notice: t('.success')
      # redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render 'events/show', alert: t('.error')
      # render :new
    end
  end

  # DELETE /comments/1
  def destroy
    if current_user_can_edit?(@comment)
      @comment.destroy!
      message = { notice: t('.success') }
    else
      message = { alert: t('.error') }
    end
    redirect_to @event, message

    # redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    # params.fetch(:comment, {})
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now unless comment.user.email == mail
    end
  end
end
