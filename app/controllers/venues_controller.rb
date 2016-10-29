class VenuesController < ApplicationController
  def new
    @venue = Venue.new
  end

  def create
    @venue = current_user.venues.build(venue_params)
      if @venue.save
        flash[:success] = "Venue created successfully"
        redirect_to root_path
      else
        flash[:error] = "Error - Can't create venue"
        render 'new'
      end
  end

  def venue_params
    params.require(:venue).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name)
  end
end
