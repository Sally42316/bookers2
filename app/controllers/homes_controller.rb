class HomesController < ApplicationController
  def top
  end

  def about
  end

  def index
    if logged_in?
      flash[:signed_up]
    else
      flash[:errors]
    end
  end
end

