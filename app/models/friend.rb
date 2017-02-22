class Friend < ApplicationRecord
  belongs_to :friend1, :foreign_key => 'user_id', :class_name => 'User'
  belongs_to :friend2, :foreign_key => 'user_id', :class_name => 'User'
end
