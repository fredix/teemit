class HostStatsUptime
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :average, :type => Float, :default => 0.0
  field :time, :type => Float, :default => 0.0
  field :days, :type => String
  field :average, :type => Float, :default => 0.0
  field :max_time, :type => Float, :default => 0.0

  embedded_in :host, :inverse_of => :stats_uptime

  def created_at_to_date
    return self.created_at.to_date
  end
end
