class User < ActiveRecord::Base
  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :likes, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence:   true,
                    uniqueness: true,
                    format:     VALID_EMAIL_REGEX
end
