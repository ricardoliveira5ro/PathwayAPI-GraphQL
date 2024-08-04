class CreateRoadmaps < ActiveRecord::Migration[7.1]
  def change
    create_table :roadmaps do |t|
      t.string :title
      t.string :description
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
