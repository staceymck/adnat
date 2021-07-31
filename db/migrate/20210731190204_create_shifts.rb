class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :start, null: false
      t.datetime :finish, null: false
      t.integer :break_length, null: false

      t.timestamps
    end
  end
end
