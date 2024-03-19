class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  def response_for_user(user)
    responses.find_by(user: user)
  end

  def build_response_for_user(user)
    responses.build(user: user)
  end

  def create_response(params, user)
    responses.create(params.merge(user: user))
  end

  def yes_percentage
    responses_count = responses.count
    return 0 if responses_count.zero?
  
    yes_count = responses.where(answer: true).count
    (yes_count.to_f / responses_count) * 100
  end
  
  def no_percentage
    responses_count = responses.count
    return 0 if responses_count.zero?
  
    no_count = responses.where(answer: false).count
    (no_count.to_f / responses_count) * 100
  end
end
