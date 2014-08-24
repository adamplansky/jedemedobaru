class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create 
    @contact = Contact.new(secure_params)
    puts @contact
    if @contact.valid?
     UserMailer.ask_email(@contact).deliver
     redirect_to root_path
   else
     render :new
   end
  end
  
  
  def secure_params
    params.require(:contact).permit(:name, :email, :message)
  end
end