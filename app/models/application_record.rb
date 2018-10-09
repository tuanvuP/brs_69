class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :sort_by_desc, ->{order created_at: :desc}
end
