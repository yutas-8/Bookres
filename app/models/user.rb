class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comment, dependent: :destroy
  
  # 自分がフォローされる側の関係性
  has_many :active_relationships,class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローする側の関係性
  has_many :passive_relationships,class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #自分がフォローしている人 
  has_many :following, through: :active_relationships, source: :followed
  # 自分をフォローしている人
  has_many :followers, through: :passive_relationships, source: :follower
  
  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end

  validates :name, presence: true
  validates :name, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  
  def self.search(search, word)
      if search == "forward_match"
                        @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
                        @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
                        @user = User.where("#{word}")
      elsif search == "partial_match"
                        @user = User.where("name LIKE?","%#{word}%")
      else
                        @user = User.all
      end
  end



end
