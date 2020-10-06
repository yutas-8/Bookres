class Book < ApplicationRecord

   belongs_to :user
   has_many :favorites, dependent: :destroy
   has_many :book_comment, dependent: :destroy
   
   def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
   end

   validates :title, presence: true
   validates :body, presence: true
   validates :body, length: {maximum: 200}
   
   def self.search(search, word)
      if search == "forward_match"
                        @book = Book.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
                        @book = Book.where("title LIKE?","%#{word}")
      elsif search == "perfect_match"
                        @book = Book.where("#{word}")
      elsif search == "partial_match"
                        @book = Book.where("title LIKE?","%#{word}%")
      else
                        @book = Book.all
      end
   end

end
