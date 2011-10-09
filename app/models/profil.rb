class Profil
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to_related :user
  has_many_related :hosts

  field :nickname, :type => String, :default => "nickname"
  field :email, :type => String
  field :context, :type => String, :default => "default"  #home, work, customer, ...
  field :public, :type => Boolean, :default => false

end
