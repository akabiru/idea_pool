class CreateIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :ideas do |t|
      t.integer :confidence, default: 0
      t.integer :ease, default: 0
      t.integer :impact, default: 0
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
