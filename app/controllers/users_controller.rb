class UsersController < ApplicationController
  def index
    @user = current_user # サインインしているユーザーを取得するなどの方法で@userをセットする
    @users = User.all
    @book_new = Book.new
  end

  def show
    @book_new = Book.new
    
    @user = User.find(params[:id])
    # @book = Book.find_by(user_id: @user.id) 
    @books = @user.books
    # @book = Book.find(params[:id])

    # ↓空の@bookを作る
    # データがない箱
    # ↓作ることでshow.html.erbからbooks_controller.rbの def createの@book = Book.new(book_params)が使える
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:updated] = "Your account has been updated successfully."
      redirect_to user_path(@user)
    else
      flash[:updated] = "Your account has error"
      render :edit
    end
  end

  # def create
    # @user = User.new(user_params)
    # if @user.save
      # redirect_to user_path(@user.id)
    # else
      # render :new
    # end
  # end


  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
