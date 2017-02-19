class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.order("id ASC LIMIT 5") #limit(5) would also work here, but not first(5)
  end

  def self.dinghy
    self.all.where("length < 20")
  end

  def self.ship
    self.all.where("length >= 20")
  end

  def self.last_three_alphabetically
    self.all.order("name DESC LIMIT 3")
  end

  def self.without_a_captain
    self.all.where(captain: nil)
  end

  def self.sailboats
    self.all.joins(:classifications).where("classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications
    self.all.joins(:classifications).group("boats.name").having("count(*) = 3")
  end
end
