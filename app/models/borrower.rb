class Borrower < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    has_many :books, through: :borrowings

    validates :name, presence:true

end
