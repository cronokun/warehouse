class Box < ActiveRecord::Base
  validates :name, presence: true
  validates :volume, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
