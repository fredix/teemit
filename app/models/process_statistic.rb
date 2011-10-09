class ProcessStatistic
  include Mongoid::Document
  include Mongoid::Timestamps
  cache

  belongs_to_related :host

  field :process_number, :type => Integer, :default => 0

  index :host_id, :unique => true, :background => true

  embeds_many :processus, :class_name => 'Processus'
end
