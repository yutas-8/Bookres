class UsersController < ApplicationController
    before_action :authenticate_user!#ログイン認証成功してないとどの画面も表示されない(保留)
    before_action :correct_user, only:[:edit, :update]

   def index
      @users = User.all
      @book = Book.new
   end

   def show
      @user = User.find(params[:id])
      @books = @user.books.page(params[:page]).reverse_order
      @book = Book.new

   end

   def edit

   end

   def update

      if @user.update(user_params)
         redirect_to user_path(@user.id), notice: "You have updated user successfully."
      else
         render :edit
      end
   end
   
   def following
      @user  = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
   end

   def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
   end

   private
   def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
   end

   #↓自分のアカウントでしか編集できないようにする
   def correct_user
      @user = User.find(params[:id])
      redirect_to(user_url(current_user))unless @user == current_user
   end

end