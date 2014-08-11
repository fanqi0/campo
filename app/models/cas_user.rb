# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  name                   :string(255)
#  gender                 :string(255)
#  mobile                 :string(255)
#  phone                  :string(255)
#  from                   :string(255)
#  user_type              :string(255)
#  uuid                   :string(255)
#  status                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  crypted_password       :string(255)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class CasUser < ActiveRecord::Base
  self.establish_connection "cas_#{Rails.env}".to_sym
  self.table_name = "users"
  #validates  :unconfirmed_email, uniqueness: true, presence: true
end
