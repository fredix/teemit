class HostStatsProcess
  include Mongoid::Document
  include Mongoid::Timestamps

  field :counter, :type => Integer, :default => 0
  field :process_number, :type => Integer, :default => 0

  embedded_in :host, :inverse_of => :stats_process

  def created_at_to_date
    return self.created_at.to_date
  end
end
