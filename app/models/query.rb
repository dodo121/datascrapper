class Query < ActiveRecord::Base
  has_many :links, dependent: :destroy
  belongs_to :user

  validates :name, presence: :true
end
