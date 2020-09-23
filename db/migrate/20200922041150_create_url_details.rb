class CreateUrlDetails < ActiveRecord::Migration
  def change
    create_table :url_details do |t|
      t.integer :url_id
      t.string :ip_address
      t.string :country
      t.timestamps
    end
  end
end
