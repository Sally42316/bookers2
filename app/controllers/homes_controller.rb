class HomesController < ApplicationController
  def top
  end

  def about
  end

  def index
    if logged_in?
      flash[:success] = "Loged in successfully"
    end
  end
end

