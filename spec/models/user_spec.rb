require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:users_answers).dependent(:destroy) }
  it { should have_many(:answers).through(:users_answers) }

  it { should have_many(:users_questions).dependent(:destroy) }
  it { should have_many(:questions).through(:users_questions) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
