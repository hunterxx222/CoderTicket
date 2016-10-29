class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
