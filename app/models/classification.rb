require 'pry'

class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def self.my_all
    self.all
  end

  def self.longest
    maxlong = self.all.joins(:boats).maximum("length")
    self.all.joins(:boats).where('length = ?', maxlong)
  end
end
