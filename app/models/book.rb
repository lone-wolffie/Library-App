class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    has_many :borrowers, through: :borrowings
      
    validates :title, :author, presence:true
    
end
