class EventMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.subscription.subject
  #
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event
    mail to: event.user.email, subject: t('.subject', title: event.title)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.comment.subject
  #
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: t('.subject', title: event.title)
  end

  def photo(event, photo, email)
    @photo = photo
    @event = event
    @aaa = photo.photo
    @filename = photo.photo.filename
    attachments.inline[@filename] = photo.photo.read
    # attachments.inline["photo#{photo.photo.extension}"] = photo.photo.read
    mail to: email, subject: t('.subject', title: event.title)
  end
end
