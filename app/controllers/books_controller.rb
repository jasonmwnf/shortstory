class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)

    if book.save
      flash[:success] = "Book has been created."
      redirect_to book_path(book)
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

    def book_params
      params.require(:book).permit(:name, :author, :description, :availability)
    end
end