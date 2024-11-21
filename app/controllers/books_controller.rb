class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user 
    @book_new = Book.new
    @book = Book.new
  end

  def show
    @book_new = Book.new
     @book = Book.find(params[:id])
     @user = @book.user

  end

  def edit
    @book = Book.find(params[:id])
    # if @book.save
      # flash[:notice] = "You've uodated book successfully"
      # redirect_to book_path(@book)
    # else
      # render :new
    # end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You've created book successfully"
      redirect_to book_path(@book)
    else
      flash[:notice] = "create error"
      @books = Book.all
      @user = current_user
      render :index
    end

    # フラッシュメッセージ
    # １. データを受け取り新規登録するためのインスタンス作成
    # @list = List.new(list_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    # if @list.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      # flash[:notice] = "投稿に成功しました。"
      # redirect_to list_path(@list.id)
      # <div>
      # <%= flash[:notice] %>
    # </div>
    
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You've updated book successfully"
      redirect_to book_path(@book)
    else
      flash[:notice] = "error"
      render :edit
    end
  end
  

   # ストロングパラメータ
   def book_params
    params.require(:book).permit(:title, :body)
  end
end
