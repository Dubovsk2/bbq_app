class CommentsController < ApplicationController
  include ApplicationHelper
  before_action :set_event
  before_action :set_comment, only: %i[destroy edit update]


  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user
    if @new_comment.save
      redirect_to @event, notice: t('controllers.comments.created')
    else
      render 'events/show'
    end
  end

  def destroy
    msg = { notice: t('controllers.comments.destroyed') }
    if current_user_can_edit?(@event)
      @comment.destroy!
    else
      msg = { alert: t('controllers.comments.error') }
    end
    redirect_to @event, msg
  end

  def edit 
  end
  def update
    if current_user_can_edit?(@comment)
      @comment.update(comment_params)
      redirect_to @event, notice: 'good'
    else
      redirect_to @event, alert: t('controllers.comments.error')
    end
  end

  private
  
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.fetch(:comment, {}).permit(:body, :user_name)
  end
end
