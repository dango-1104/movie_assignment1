class AddMovieNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :movie_name, :string
  end
end
