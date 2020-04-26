class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end
