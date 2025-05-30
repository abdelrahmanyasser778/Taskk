class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy


  validates :title, :body, presence: true
  validate :must_have_at_least_one_tag

  after_create :schedule_deletion

  private

  def must_have_at_least_one_tag
    errors.add(:tags, 'must have at least one') if tags.blank? || tags.empty?
  end

  def schedule_deletion
    DeleteOldPostsJob.perform_in(5.seconds, self.id)
  end
end
