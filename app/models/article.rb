class Article < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 5 }
    has_many :likes, :as => :entity, dependent: :destroy
end
  