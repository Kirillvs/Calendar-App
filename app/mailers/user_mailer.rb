class UserMailer < ApplicationMailer
  default from: 'notification@sandboxff66a3d6820c45f8a1bfdaaf29d3fac2.mailgun.org'

  def notification_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: 'Event occured')
  end
end
