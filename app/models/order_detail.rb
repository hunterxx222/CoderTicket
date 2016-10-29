class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type
end
