class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :code, null: false, limit: 7, index: { unique: true }
      t.string :destination, null: false

      t.timestamps
    end
  end
end
