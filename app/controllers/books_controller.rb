class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create]
  before_action :set_book, only: [:show, :edit, :update]

  def index
    @books = Book.where(availability: true)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:success] = "Book has been created."
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize! :manage, @book
  end

  def update
    authorize! :manage, @book

    if @book.update(book_params)
      flash[:success] = "The book was updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private

    def book_params
      params.require(:book).permit(:name, :author, :description, :availability, :image, :resource, :price)
    end

    def set_book
      @book = Book.friendly.find(params[:id])
    end
end