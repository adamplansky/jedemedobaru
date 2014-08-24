class Contact < ActiveRecord::Base
  has_no_table

  column :name, :string
  column :email, :string
  column :message, :string
  
end

