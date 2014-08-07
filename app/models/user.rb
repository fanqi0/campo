class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, default: 'wavatar', rating: 'G', size: 48
  mount_uploader :avatar, AvatarUploader

  has_secure_password
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  has_many :like_topics, through: :likes, source: :likeable, source_type: 'Topic'
  has_many :like_comments, through: :likes, source: :likeable, source_type: 'Comment'

  has_many :attachments, dependent: :delete_all

  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }

  scope :unlocked, -> { where(locked_at: nil) }
  scope :locked, -> { where.not(locked_at: nil) }
  scope :top, ->(n) { order(comments_count: :desc, topics_count: :desc).limit(n) }

  after_create :syn_info_to_sso
  before_save  :syn_confirmed_at_to_sso,

  def syn_info_to_sso
    cu = CasUser.create_with(self.attributes.keep_if{ |k, v| (CasUser.attribute_names - ['id']).include?(k) }).find_or_initialize_by(email: email)
    cu.encrypted_password = devise_password_digest(self.password) if cu.encrypted_password.blank? or cu.crypted_password.blank?
    cu.save!
  end

  def syn_confirmed_at_to_sso
    if confirmed? or username_changed? or email_changed? or mobile_changed?
      cu = CasUser.find_by(email: email)
      if cu.present?
        cu.confirmed_at = Time.now if confirmed_changed?
        cu.username = username if username_changed?
        cu.mobile = mobile if mobile_changed?
        cu.save!
      end
    end
  end

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && Rack::Utils.secure_compare(user.remember_token, token)) ? user : nil
  end

  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include?(email)
  end

  def lock
    update_attribute :locked_at, current_time_from_proper_timezone
  end

  def unlock
    update_attribute :locked_at, nil
  end

  def locked?
    locked_at.present?
  end

  def self.verifier_for(purpose)
    @verifiers ||= {}
    @verifiers.fetch(purpose) do |p|
      @verifiers[p] = Rails.application.message_verifier("#{self.name}-#{p.to_s}")
    end
  end

  def password_reset_token
    self.class.verifier_for('password-reset').generate([id, Time.now])
  end

  def self.find_by_password_reset_token(token)
    user_id, timestamp = verifier_for('password-reset').verify(token)
    User.find_by(id: user_id) if timestamp > 1.hour.ago
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def confirm
    update_attribute :confirmed, true
  end

  def confirmation_token
    self.class.verifier_for('confirmation').generate([id, Time.now])
  end

  def self.find_by_confirmation_token(token)
    user_id, timestamp = verifier_for('confirmation').verify(token)
    User.find_by(id: user_id) if timestamp > 1.hour.ago
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  protected
  def devise_password_digest(password)
    ::BCrypt::Password.create("#{password}#{nil}", cost: 10).to_s
  end

end
