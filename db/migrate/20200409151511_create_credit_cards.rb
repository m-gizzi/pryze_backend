class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.string :last_four
      t.string :square_ccof_id
      t.string :card_brand
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
