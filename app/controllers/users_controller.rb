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

    # ↓悩んだ跡
    # @bookk = Book.find(params[:id])

    # ↓空の@bookを作る
    # データがない箱
    # ↓作ることでshow.html.erbからbooks_controller.rbの def createの@book = Book.new(book_params)が使える
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You've updated book successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
