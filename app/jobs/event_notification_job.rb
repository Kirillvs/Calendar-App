class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id, event)
    user = User.find(user_id)
    UserMailer.notification_email(user, event).deliver_now
    if event.repetitive
      EventNotificationJob.set(wait: 1.send(event.repeat_period)).perform_later(user.id, event)
    end
  end
end
