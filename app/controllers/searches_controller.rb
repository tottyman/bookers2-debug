class SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]
    
    if @range == "User"
      @users = User.looks(@search, @word)
    else
      @books = Book.looks(@search, @word)
    end
    
  end
  
end
