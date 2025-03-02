class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :borrower

  validates :borrowed_on, presence:true
  validate :return_date_after_borrow_date

  def return_date_after_borrow_date
    if returned_on.present? && returned_on < borrowed_on
       errors.add(:returned_on, "must be after borrowed date")
    end
  end

end
