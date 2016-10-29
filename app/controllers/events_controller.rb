class EventsController < ApplicationController
  before_action :require_login, only: [:new, :edit, :update, :publish]
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

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  def my_events
    load_user
    @event = Event.where(user_id: @user.id)
  end

end
