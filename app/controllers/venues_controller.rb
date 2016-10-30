class VenuesController < ApplicationController
  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
      if @venue.save
        flash[:success] = "Venue created successfully"
        redirect_to root_path
      else
        flash[:error] = "Error - Can't create venue"
        render 'new'
      end
  end

  def venue_params
    params.require(:venue).permit(:name, :region_id, :full_address)
  end
end
