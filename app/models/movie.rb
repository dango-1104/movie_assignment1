class Movie < ApplicationRecord
  belongs_to :user
  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :movie_image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :movie_image_id, presence: true
  validates :body, presence: true
  validates :star, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @movie = Movie.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @movie= Movie.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @movie = Movie.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @movie = Movie.where("title LIKE?","%#{word}%")
    else
      @movie = Movie.all
    end
  end

end
