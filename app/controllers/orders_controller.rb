class OrdersController < ApplicationController
  def new
    @event = Event.find params[:event_id]
  end

  def create
    @event = Event.find(params[:order][:event_id])

    @event.ticket_types.each do |type|
      quantity = params[:quantity]["#{type.id}"].to_i
      if type.max_quantity < quantity
        flash[:error] = "Maximum quantity of #{type.max_quantity} exceeded for #{type.name}"
        redirect_to root_path
      else
      		@order = Order.new order_params
      		params[:quantity].each do |key, value|
            @event.ticket_types.each do |type|
              order_details = OrderDetail.new(ticket_type_id: key, quantity: value)
            end
          end

    		if @order.save
    			flash[:success] = "Successfully booked"
          redirect_to root_path
    		else
    			flash[:error] = "Failed to book"
    		end
      end
    end
  end

  def order_params
     params.require(:order).permit(:name, :phone, :address)
  end
end
