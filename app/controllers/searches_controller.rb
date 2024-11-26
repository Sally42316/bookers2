class SearchesController < ApplicationController
    before_action :authenticate_user!

    def search
      @range = params[:range]
  
      if @range == "User"
        @users = User.looks(params[:search], params[:word])
      else
        @books = Book.looks(params[:search], params[:word])
      end

      respond_to do |format|
        format.html { render 'searchs/search_result' } # search_result.html.erbを指定
      end
    end

    
end
