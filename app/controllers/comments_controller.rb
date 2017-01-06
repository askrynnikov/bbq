class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  # POST /comments
  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      redirect_to @event, notice: I18n.t('controllers.comments.created')
      # redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render 'events/show', alert: I18n.t('controllers.comments.error')
      # render :new
    end
  end

  # DELETE /comments/1
  def destroy
    if current_user_can_edit?(@comment)
      @comment.destroy!
      message = { notice: I18n.t('controllers.comments.destroyed') }
    else
      message = { alert: I18n.t('controllers.comments.error') }
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
end
