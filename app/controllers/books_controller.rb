class BooksController < ApplicationController
  def index
    @user = current_user # サインインしているユーザーを取得するなどの方法で@userをセットする
    @books = Book.all
    @book_new = Book.new
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id  # ログイン中のユーザーの ID を book の user_id に代入
    if @book.save
      redirect_to books_path, notice: "Book was successfully created."
    else
      render :index
    @book.save
    redirect_to book_path(@book)
    end
end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      render :edit
    end
  end

   # ストロングパラメータ
   def book_params
    params.require(:book).permit(:title, :body)
  end
end
