class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: {unique: true}
      t.belongs_to :organisation, foreign_key: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
