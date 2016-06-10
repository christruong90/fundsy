class Campaign < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :goal, numericality: {greater_than_or_equal_to: 10}

  def upcased_title
    title.upcase
  end
end
