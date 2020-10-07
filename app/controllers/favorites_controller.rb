class FavoritesController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        @favorite = @book.favorites.create(user_id: current_user.id)
        # redirect_back(fallback_location: root_path)#非同期通信の為削除
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        @favorite = @book.favorites.find_by(user_id: current_user.id).destroy
        # redirect_back(fallback_location: root_path)#非同期通信の為削除
    end
end
