class HostRam
  include Mongoid::Document
  include Mongoid::Timestamps

  field :mem_ram, :type => Integer, :default => 0
  field :mem_total, :type => Float, :default => 0.0
  field :swap_total, :type => Float, :default => 0.0
  field :public, :type => Boolean, :default => true

  embedded_in :host, :inverse_of => :ram

  def created_at_to_date
    return self.created_at.to_date
  end
end
