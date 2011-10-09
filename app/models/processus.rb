class Processus
  include Mongoid::Document
#  include Mongoid::Timestamps
  cache

  field :pid, :type => Integer
  field :state_name, :type => String
  field :state_state, :type => String
  field :state_ppid, :type => Integer
  field :state_tty, :type => String
  field :state_priority, :type => Integer
  field :state_nice, :type => Integer
  field :state_processor, :type => Integer
  field :state_threads, :type => Integer
  field :mem_size, :type => String
  field :mem_resident, :type => String
  field :mem_share, :type => String
  field :mem_minor_faults, :type => String
  field :mem_major_faults, :type => String
  field :mem_page_faults, :type => String
  field :time_start_time, :type => String
  field :time_user, :type => Integer
  field :time_sys, :type => Integer
  field :time_total, :type => Integer

  embedded_in :process_statistic, :inverse_of => :processus

 # def created_at_to_date
  #  return self.created_at.to_date
 # end
end
