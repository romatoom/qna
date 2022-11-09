class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :users_answers, dependent: :destroy
  has_many :answers, through: :users_answers

  has_many :users_questions, dependent: :destroy
  has_many :questions, through: :users_questions
end
