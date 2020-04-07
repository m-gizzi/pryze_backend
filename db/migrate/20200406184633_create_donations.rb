class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.float :amount
      t.belongs_to :game, null: false, foreign_key: true
      t.belongs_to :fundraiser, null: false, foreign_key: true

      t.timestamps
    end
  end
end
