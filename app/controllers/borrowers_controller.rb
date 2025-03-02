class BorrowersController < ApplicationController
    def index
      @borrowers = Borrower.all
    end
  
    def show
      @borrower = Borrower.find(params[:id])
      @borrowings = @borrower.borrowings.includes(:book)
    end
  end

  