class Firefighter < ActiveRecord::Base
  has_paper_trail

  attr_accessible :firstname, :lastname, :identification

  has_many :endowment_lines

  validates :firstname, :lastname, :identification, presence: true
  validates :identification, uniqueness: true

  def to_s
    [self.lastname, self.firstname].join(' ')
  end
end
