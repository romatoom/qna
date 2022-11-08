class UsersAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :answer
end
