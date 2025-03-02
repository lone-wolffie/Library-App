class BooksController < ApplicationController
    def index
      @books = Book.all
    end
  
    def show
      @book = Book.find(params[:id])
      @borrowings = @book.borrowings.includes(:borrower)
    end
  
    def new
      @book = Book.new
    end
  
    def create
      @book = Book.new(book_params)
      @book.available = true
      if @book.save
        redirect_to books_path, notice: "Book added successfully!"
      else
        render :new
      end
    end
  
    def edit
      @book = Book.find(params[:id])
    end
  
    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to books_path, notice: "Book updated successfully!"
      else
        render :edit
      end
    end
  
    # def destroy
    #   @book = Book.find(params[:id])
    #   @book.destroy
    #   redirect_to books_path, notice: "Book deleted successfully!"
    # end

    def destroy
        @book = Book.find(params[:id])
        @book.borrowings.destroy_all  # Remove all borrowings first
        @book.destroy
        redirect_to books_path, notice: "Book deleted successfully!"
      end
  
    def borrow
      @book = Book.find(params[:id])
      borrower = Borrower.find_or_create_by(name: params[:borrower_name])
  
      if @book.available
        Borrowing.create!(book: @book, borrower: borrower, borrowed_on: Date.today)
        @book.update!(available: false)
        redirect_to book_path(@book), notice: "Book borrowed successfully!"
      else
        redirect_to book_path(@book), alert: "Book is already borrowed."
      end
    end
  
    def return
      @book = Book.find(params[:id])
      borrowing = @book.borrowings.where(returned_on: nil).last
  
      if borrowing
        borrowing.update!(returned_on: Date.today)
        @book.update!(available: true)
        redirect_to book_path(@book), notice: "Book returned successfully!"
      else
        redirect_to book_path(@book), alert: "No active borrow record found!"
      end
    end
  
    private
  
    def book_params
      params.require(:book).permit(:title, :author)
    end
  end