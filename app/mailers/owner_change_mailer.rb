class OwnerChangeMailer < ApplicationMailer
  def owner_change_mail(user, owner)
    @user = user
    @owner = owner
    mail to: @user.email, subject: "オーナー権限変更のご連絡"

  end
end
