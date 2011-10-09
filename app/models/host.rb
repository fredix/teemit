#require 'carrierwave/orm/mongoid'

class Host
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to_related :profil
  belongs_to_related :user
  belongs_to_related :osystem
  belongs_to_related :os_version


  has_many_related :uptime_statistics
  has_many_related :load_statistics
  has_many_related :memory_statistics
  has_many_related :network_statistics
  has_many_related :cpu_statistics
  has_many_related :process_statistics
  has_many_related :host_comments

  embeds_many :last_comments, :class_name => 'HostLastComment'
  embeds_one :network, :class_name => 'HostNetwork'
  embeds_one :cpu, :class_name => 'HostCpu'
  embeds_one :ram, :class_name => 'HostRam'

  embeds_one :stats_uptime, :class_name => 'HostStatsUptime'
  embeds_one :stats_load, :class_name => 'HostStatsLoad'
  embeds_one :stats_network, :class_name => 'HostStatsNetwork'
  embeds_one :stats_memory, :class_name => 'HostStatsMemory'
  embeds_one :stats_cpu, :class_name => 'HostStatsCpu'
  embeds_one :stats_process, :class_name => 'HostStatsProcess'



#  has_many :hbadges


  index :uuid, :unique => true, :background => true
  index :pub_uuid, :unique => true, :background => true

  mount_uploader :avatar, AvatarUploader


#  before_create :generate_uuid


#  belongs_to :user
#  belongs_to :osystem
#  has_many :host_statistics


  #before_create { self.counter = Host.last.counter += 1 }


  before_destroy { |record| 
    record.osystem.hosts_number -= 1
    record.osystem.save
    record.user.hosts_number -=1
    record.user.save
    UptimeStatistic.destroy_all(:conditions => {:host_id => record.id})
    LoadStatistic.destroy_all(:conditions => {:host_id => record.id})
    MemoryStatistic.destroy_all(:conditions => {:host_id => record.id})
    NetworkStatistic.destroy_all(:conditions => {:host_id => record.id})
    CpuStatistic.destroy_all(:conditions => {:host_id => record.id})
    ProcessStatistic.destroy_all(:conditions => {:host_id => record.id})
  }


  scope :is_public, lambda { 
        where(:public => true, :blocked => false)
    } 

#  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "50x50>" }

#  field :profil_id, ObjectId
#  field :user_id, ObjectId
#  field :osystem_id, ObjectId

  field :followers, :type => Array
  field :following, :type => Array
  field :friends, :type => Array
  field :children, :type => String
  field :pub_uuid, :type => String, :unique => true
  field :uuid, :type => String, :unique => true
  field :public, :type => Boolean, :default => false
  field :blocked, :type => Boolean, :default => false
  field :counter, :type => Integer, :default => 0
  field :host_type, :type => String

  ###### from sigar #####
  field :os_version_number, :type => String # kernel for linux
  field :machine, :type => String
  field :patch_level, :type => String
  field :architecture, :type => String # x86 x86_64 ia64 alpha sparc mips powerpc
  field :description, :type => String


=begin
  field :hostname, :type => String
  field :domain_name, :type => String
  field :default_gateway, :type => String
  field :primary_dns, :type => String
  field :secondary_dns, :type => String
  field :primary_interface, :type => String
  field :primary_addr, :type => String

  field :cpu_vendor, :type => String
  field :cpu_model, :type => String
  field :cpu_mhz, :type => Integer
  field :cpu_cache_size, :type => String
  field :cpu_number, :type => Integer
  field :cpu_total_cores, :type => Integer
  field :cpu_total_sockets, :type => Integer
  field :cpu_cores_per_socket, :type => Integer


  field :mem_ram, :type => Integer
  field :mem_total, :type => Float
  field :swap_total, :type => Float
  ###### from sigar #####


  field :public_uptime, :type => Boolean, :default => true
  field :public_load, :type => Boolean, :default => true
  field :public_memory, :type => Boolean, :default => true
  field :public_hardware, :type => Boolean, :default => true
=end




  # field :created_at, Date, :default => Date.now
  # field :updated_at, Date




=begin
  def create
    self.async_send(:create, self)
  end
=end

  private

    def generate_uuid
      self.uuid = UUIDTools::UUID.timestamp_create.to_s
      self.pub_uuid = UUIDTools::UUID.timestamp_create.to_s
    end


end
