class DeleteOldPostsJob
    include Sidekiq::Job
    queue_as :default

    def perform(post_id)
      post = Post.find_by(id: post_id)
      post&.destroy if post.created_at < 24.hours.ago
    end
  end
  