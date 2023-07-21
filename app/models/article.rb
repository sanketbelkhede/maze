class Article < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    validates :title, presence: true
    validates :dob, presence: true
    validates :body, presence: true, length: { minimum: 5 }
    
end
  