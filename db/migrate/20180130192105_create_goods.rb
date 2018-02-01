class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :title
      t.date :date
      t.decimal :revenue, precision: 10, scale: 2

      t.timestamps
    end

    add_index :goods, [:title, :date], unique: true
  end
end
