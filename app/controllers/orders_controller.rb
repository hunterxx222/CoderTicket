class OrdersController < ApplicationController
  def new
    @event = Event.find params[:event_id]
  end

  def create
     @event = Event.find(params[:order][:event_id])
       @order = Order.new(order_params)

       params[:quantity].each do |key, value|
         order_details = OrderDetail.new(ticket_type_id: key, quantity: value)
         order_details.ticket_type.max_quantity -= value.to_i
         @order.order_details << order_details
       end

       begin
         Order.transaction do
           @order.save!
           @order.order_details.each do |od|
             od.ticket_type.save!
           end
         end

         flash[:notice] = 'Order submitted. Thanks!'
         redirect_to root_path
       rescue
         @order.errors.each do |key, value|
           errors << "#{key} #{value}"
         end

         flash[:error] = errors.join("<br/>").html_safe
         redirect_to new_event_order_path(build_params)
       end
     end
   end
