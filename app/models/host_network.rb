class HostNetwork
  include Mongoid::Document
  include Mongoid::Timestamps

  field :hostname, :type => String
  field :domain_name, :type => String
  field :default_gateway, :type => String
  field :primary_dns, :type => String
  field :secondary_dns, :type => String
  field :primary_interface, :type => String
  field :primary_addr, :type => String
  field :public, :type => Boolean, :default => true


  embedded_in :host, :inverse_of => :network


  def created_at_to_date
    return self.created_at.to_date
  end
end
