class EventsController < ApplicationController
  before_action :require_login, only: [:new, :edit, :update, :publish]
  def index
    if params[:search]
      @events = Event.where(['name ILIKE ?', "%#{params[:search]}%"])
    else
      @events = Event.where("starts_at > ?", Time.now )
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
      if @event.save
        flash[:success] = "Event created successfully"
        redirect_to root_path
      else
        flash[:error] = "Error - Can't create event"
        render 'new'
      end
  end

  def edit
    @event = Event.find(params[:id])

    unless current_user.id == @event.user_id
      flash[:error] = 'You must be the creator to edit this event'
      redirect_to event_path(@event)
    end
  end

  def update
    @event = Event.find(params[:id])
     if current_user.id != @event.user_id
       flash[:error] = 'You must be the creator to edit this event'
       redirect_to event_path(@event)
     else @event.update(event_params)
       flash[:notice] = 'Event updated'
       redirect_to event_path(@event)
     end
  end

  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
  end

  def my_events
    @events = Event.where(user_id: current_user.id)
  end

end
