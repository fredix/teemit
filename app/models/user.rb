#require 'carrierwave/orm/mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :confirmable, :lockable, :recoverable, :rememberable, :registerable, :trackable, :timeoutable, :validatable, :token_authenticatable

#  attr_accessible :avatar, :remote_avatar_url, :avatar_cache, :remove_avatar

  before_create :generate_uuid, :generate_counter, :ensure_authentication_token 
  after_create :generate_profil


  scope :is_public, lambda {
        where(:public => true, :blocked => false, :confirmed_at.ne => nil)
    }


  # Setup accessible (or protected) attributes for your model
  #  attr_accessible :email, :password, :password_confirmation


 # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::

#  field :email, String, :required => true, :unique => true
  field :followers, :type => Array
  field :following, :type => Array
  field :friends, :type => Array
  field :gravatar, :type => Boolean, :default => true
  field :guest, :type => Boolean, :default => true
  field :pub_uuid, :type => String, :unique => true
  field :uuid, :type => String, :unique => true
  field :login, :type => String, :required => true, :unique => true
  field :firstname, :type => String
  field :lastname, :type => String
  field :pub_uuid, :type => String
  field :blocked, :type => Boolean, :default => false
  field :activated, :type => Boolean, :default => false

  field :country, :type => String
  field :state, :type => String
  field :city, :type => String
  field :jabber, :type => String
  field :gender, :type => String
  field :birthday, :type => Date
  field :public, :type => Boolean, :default => false         
  field :hosts_number, :type => Integer, :default => 0
  field :public_hosts_number, :type => Integer, :default => 0
  field :counter, :type => Integer, :default => 0
  field :timezone, :type => String, :default => "UTC"

=begin
  field :email, String, :index => true , :required => true, :unique => true

  field :comment_count, Integer
  field :encrypted_password, String
  field :password_salt, String
  field :reset_password_token, String
  field :remember_token, String
  field :remember_created_at, Time
  field :sign_in_count, Integer
  field :current_sign_in_at, Time
  field :current_sign_in_ip, String
=end


  


  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_uniqueness_of :login
  RegEmailName = '[\w\.%\+\-]+'
  RegDomainHead = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i

#  validates_presence_of :email, :unique => true
  validates_length_of :email, :within => 6..100, :allow_blank => false
  validates_format_of :email, :with => RegEmailOk, :allow_blank => false, :key => true
 
  # Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::

  has_many_related :profils
  has_many_related :hosts
#  has_many_related :ubadges


  mount_uploader :avatar, AvatarUploader


  scope :by_country, :only => :country, :where =>  {:country.ne => "" , :confirmed_at.ne => nil}
  scope :by_city, :only => :city, :where =>  {:city.ne => "" , :confirmed_at.ne => nil}


  def login=(login)
    write_attribute(:login, login.downcase)
  end

  def city=(city)
    write_attribute(:city, city.downcase)
  end

  def country=(country)
    write_attribute(:country, country.downcase)
  end

  def email=(email)
    write_attribute(:email, email.downcase)
  end


  class << self

    def group_by_country
      only(:country).by_country.aggregate
    end

    def group_by_city
      only(:city).by_city.aggregate
    end

  end

#  has_many :hosts
#  acts_as_authentic

#  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "50x50>" }

=begin
  acts_as_authentic do |c|
    c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end # block optional



  def public_hosts_number
    return self.hosts.count(:conditions => "public IS TRUE and blocked is FALSE")
  end


  def login    
    return self.pub_uuid if !read_attribute(:login) or read_attribute(:login).empty?
    return read_attribute(:login)
  end

=end


  

#    def public_hosts_number
#      self.hosts.count(:public => true)
#    end


  private

    def generate_uuid
      self.uuid = UUIDTools::UUID.timestamp_create.to_s
      self.pub_uuid = UUIDTools::UUID.timestamp_create.to_s
    end

    def generate_profil
      self.profils.create(:nickname => self.login, :email => self.email, :context => "default")
     end


    def generate_counter
      begin
        self.counter = User.last.counter += 1
      rescue
        self.counter = 0
      end
    end


end
