class HostStatsNetwork
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :rx_rate, :type => Float, :default => 0.0
  field :tx_rate, :type => Float, :default => 0.0
  field :average_rx, :type => Float, :default => 0.0
  field :average_tx, :type => Float, :default => 0.0
  field :max_rx, :type => Float, :default => 0.0
  field :max_tx, :type => Float, :default => 0.0


  embedded_in :host, :inverse_of => :stats_network

  def created_at_to_date
    return self.created_at.to_date
  end
end
