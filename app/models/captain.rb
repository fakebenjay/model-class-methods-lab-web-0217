class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.all.joins(:classifications).where("classifications.name = 'Catamaran'").group("captains.name")
  end

  def self.sailors
    self.all.joins(:classifications).where("classifications.name = 'Sailboat'").group("captains.name")
  end

  def self.motorboaters
    self.all.joins(:classifications).where("classifications.name = 'Motorboat'").group("captains.name")
  end

  def self.talented_seamen
    moto = motorboaters.pluck(:id)
    sail = sailors.pluck(:id)
    self.all.where(id: (moto & sail))
  end

  def self.non_sailors
    sail = sailors.pluck(:id)
    self.all.where('id NOT IN (?)', sail)
  end
end
