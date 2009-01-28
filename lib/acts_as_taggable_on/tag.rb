class Tag < ActiveRecord::Base
  has_many :taggings
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # LIKE is used for cross-database case-insensitivity
  def self.find_or_create_with_like_by_name(name)
    find(:first, :conditions => ["upper(name) LIKE ?", name.upcase]) || create(:name => name)
  end
  
  # LIKE is used for cross-database case-insensitivity
  def self.find_with_like_by_name(name)
    find(:first, :conditions => ["upper(name) LIKE ?", name.upcase])
  end
  
  def self.from_param(name)
    find_with_like_by_name(name)
  end
  
  def ==(object)
    super || (object.is_a?(Tag) && name == object.name)
  end
  
  def to_s
    name
  end
  
  def to_param
    name.downcase
  end
  
  def count
    read_attribute(:count).to_i
  end
end
