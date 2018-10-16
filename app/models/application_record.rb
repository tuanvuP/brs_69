class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :sort_by_created_desc, ->{order created_at: :desc}
  scope :sort_by_named_asc, ->{order "name"}
end
