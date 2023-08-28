class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :state
      t.integer :age
      t.integer :contact_no
      t.string :type
      t.string :password_digest

      t.timestamps
    end
  end
end
