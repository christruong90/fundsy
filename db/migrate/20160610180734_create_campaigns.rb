class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :body
      t.float :goal
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
