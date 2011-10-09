class HostStatsCpu
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :combined, :type => Float, :default => 0.0
  field :average_combined, :type => Float, :default => 0.0
  field :max_combined, :type => Float, :default => 0.0

  embedded_in :host, :inverse_of => :stats_cpu

  def created_at_to_date
    return self.created_at.to_date
  end
end
