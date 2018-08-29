class AddAvatarAverageColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_url, :string
    add_column :ideas, :average_score, :float
  end
end
