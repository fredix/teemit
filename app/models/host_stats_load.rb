class HostStatsLoad
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :loadavg0, :type => Float, :default => 0.0
  field :loadavg1, :type => Float, :default => 0.0
  field :loadavg2, :type => Float, :default => 0.0
  field :average_loadavg0, :type => Float, :default => 0.0
  field :average_loadavg1, :type => Float, :default => 0.0
  field :average_loadavg2, :type => Float, :default => 0.0
  field :max_loadavg0, :type => Float, :default => 0.0
  field :max_loadavg1, :type => Float, :default => 0.0
  field :max_loadavg2, :type => Float, :default => 0.0

  embedded_in :host, :inverse_of => :stats_load

  def created_at_to_date
    return self.created_at.to_date
  end
end
