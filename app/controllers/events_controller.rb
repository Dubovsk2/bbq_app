class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event_for_current_user, only: %i[edit update destroy]
  
  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photograph = @event.photographs.build(params[:photograph])
  end

  def show
    @event = Event.find(params[:id])
    @photos = @event.photographs.take(5)
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: t('controllers.events.created')
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('controllers.events.updated')
    else 
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: t('controllers.events.destroyed')
  end

  private

  def set_event_for_current_user
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :datetime)
  end
end
