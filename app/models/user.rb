class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :movie_name, length: {maximum: 50}

  has_many :movies, dependent: :destroy
  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, content_type: ["image/jpg", "image/png", "image/gif"]

  # class Follower フォロ-する側目線
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :follower_relationships, source: :followed

  # class Followed フォロ-される側目線
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :follower

    # model/user.rb
  # ユーザーをフォローする
  def follow(user_id)
   follower_relationships.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
   follower_relationships.find_by(followed_id: user_id).destroy
  end
  # フォロー確認をおこなう
  def following?(user)
   self.followings.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
