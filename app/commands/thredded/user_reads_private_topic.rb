module Thredded
  class UserReadsPrivateTopic
    def initialize(private_topic, user)
      @private_topic = private_topic
      @user = user
    end

    def run
      private_user = Thredded::PrivateUser
        .find_by(private_topic: private_topic, user: user)
      private_user.update_attributes(read: true)

      Rails.cache.delete("private_topics_count_#{user.id}")
    end

    private

    attr_reader :private_topic, :user
  end
end
