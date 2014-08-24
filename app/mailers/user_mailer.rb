class UserMailer < ActionMailer::Base
  default to: "jedemedobaru@gmail.com"
  
  def ask_email(user)
    @user = user
    mail(from: user.email, :subject => "Jedemedobaru.cz dotaz")
  end
end
