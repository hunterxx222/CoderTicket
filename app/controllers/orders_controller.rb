class OrdersController < ApplicationController
  def new
    @event = Event.find params[:event_id]
  end

  def create
		@order = Order.new order_params
		params[:quantity].each do |key, value|
      order_details = OrderDetail.new(ticket_type_id: key, quantity: value)
			redirect_to root_path
		end

		if @order.save
			flash[:success] = "Successfully booked"
		else
			flash[:error] = "Failed to booked"
		end
  end

  def order_params
     params.require(:order).permit(:name, :phone, :address)
  end
end
