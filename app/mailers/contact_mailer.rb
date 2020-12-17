class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @agenda = contact
    mail to: @agenda.team.users.pluck(:email), subject: "アジェンダ削除のご連絡"
  end
end
