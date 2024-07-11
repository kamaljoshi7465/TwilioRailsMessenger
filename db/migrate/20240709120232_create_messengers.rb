class CreateMessengers < ActiveRecord::Migration[7.1]
  def change
    create_table :messengers do |t|
      t.string :phone_number
      t.text :body

      t.timestamps
    end
  end
end
