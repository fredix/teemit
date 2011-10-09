class HostStatsMemory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :mem_used, :type => Float, :default => 0.0
  field :average_mem_used, :type => Float, :default => 0.0
  field :max_mem_used, :type => Float, :default => 0.0
  field :swap_total, :type => Float, :default => 0.0

  embedded_in :host, :inverse_of => :stats_memory

  def created_at_to_date
    return self.created_at.to_date
  end
end
