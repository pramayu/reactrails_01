class BooksController < ApplicationController
  def index
    @books = Book.all.order('created_at desc')
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render partial: 'books/book', locals: { book: @book}
    else
      render json: @book.errors.to_json
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :sinopsis, :price, :published_on, :status)
  end
end
