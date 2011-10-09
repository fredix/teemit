class OsVersion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :vendor_version, :type => String
  field :vendor_code_name, :type => String
  field :release_date, :type => Date
  field :end_of_life, :type => Date
  field :end_of_life_desktop, :type => Date
  field :end_of_life_server, :type => Date
  field :hosts_number, :type => Integer, :default => 0
  field :description, :type => String

  belongs_to_related :osystem
  has_many_related :hosts

  def created_at_to_date
    return self.created_at.to_date
  end
end
