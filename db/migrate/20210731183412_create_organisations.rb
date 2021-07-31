class CreateOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.decimal :hourly_rate, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
