class PhotographsController < ApplicationController
  include ApplicationHelper
  before_action :set_event
  before_action :set_photograph, only: %i[show destroy]

  def create
    if current_user.present?
      @new_photograph = @event.photographs.build(photograph_params)
      @new_photograph.user = current_user
    
      if @new_photograph.save
        redirect_to @event, notice: t('controllers.photographs.created')
      else
        render "events/show"
      end
    else
      redirect_to @event, alert: t('controllers.photographs.error')
    end
  end

  def show
  end

  def index
    @photographs = @event.photographs.take(5)
  end

  def destroy
    msg = { notice: t('controllers.photographs.destroyed') }
    if current_user_can_edit?(@photograph)
      @photograph.destroy
    else
      msg = { notice: t('controllers.photographs.error') }
    end
    redirect_to @event, msg
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photograph
    @photograph = Photograph.find(params[:id])
  end

  def photograph_params
    params.require(:photograph).permit(:photo)
  end
end
