class EventsController < ApplicationController
  def index
    if params[:search]
      @events = Event.where(['name ILIKE ?', "%#{params[:search]}%"])
    else
      @events = Event.all
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

  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
  end
end
