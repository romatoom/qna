require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:users_answers).dependent(:destroy) }
  it { should have_many(:answers).through(:users_answers) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
