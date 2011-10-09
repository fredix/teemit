class HostCpu
  include Mongoid::Document
  include Mongoid::Timestamps

  field :vendor, :type => String
  field :model, :type => String
  field :mhz, :type => Integer, :default => 0
  field :cache_size, :type => String
  field :number, :type => Integer, :default => 0
  field :total_cores, :type => Integer, :default => 0
  field :total_sockets, :type => Integer, :default => 0
  field :cores_per_socket, :type => Integer, :default => 0
  field :public, :type => Boolean, :default => true


  embedded_in :host, :inverse_of => :cpu

  def created_at_to_date
    return self.created_at.to_date
  end
end
