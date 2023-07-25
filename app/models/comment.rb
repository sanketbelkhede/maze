class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :content, presence: true
  has_many :likes, :as => :entity, dependent: :destroy
end
