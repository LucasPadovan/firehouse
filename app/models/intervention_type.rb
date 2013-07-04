class InterventionType < ActiveRecord::Base
  has_paper_trail

  belongs_to :father, :class_name => 'InterventionType', :foreign_key => 'intervention_type_id'

  has_many :childrens, :class_name => 'InterventionType'

  attr_accessible :name, :priority, :father, :image, :target, :callback, :color

  validates_presence_of :name, :color

  #validates_numericality_of :priority

  scope :only_fathers, -> { where(intervention_type_id: nil) }

  scope :only_childrens, -> { !only_fathers }

  def to_s
    self.name
  end
end