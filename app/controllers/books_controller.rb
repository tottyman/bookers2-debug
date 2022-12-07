class BooksController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @bookn = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    if params[:latest]
      @books = Book.latest
    elsif params[:rate_count]
      @books = Book.rate_count
    else
      @books = Book.all
    end

    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search_book
    @keyword = params[:keyword]
    @books = Book.search(@keyword)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :category)
  end

  def is_matching_login_user
    @books = current_user.books
    @book = @books.find_by(id: params[:id])
    redirect_to books_path unless @book
  end

end
