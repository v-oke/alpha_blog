class Category < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates_uniqueness_of :name
end
