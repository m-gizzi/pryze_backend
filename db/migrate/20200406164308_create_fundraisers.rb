class CreateFundraisers < ActiveRecord::Migration[6.0]
  def change
    create_table :fundraisers do |t|
      t.string :name
      t.string :url
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
