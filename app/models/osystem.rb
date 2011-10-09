class Osystem
  include Mongoid::Document
  include Mongoid::Timestamps

  before_create :set_infos

  field :name, :type => String
  field :vendor, :type => String
  #field :vendor_version, :type => String
  #field :vendor_code_name, :type => String
  #field :release_date, :type => Date
 # field :end_of_life, :type => Date
  field :os_base, :type => String
  field :os_type, :type => String
  field :hosts_number, :type => Integer, :default => 0
  field :url, :type => String
  field :logo, :type => String #path
  field :description, :type => String

  has_many_related :hosts
  has_many_related :os_comments
  has_many_related :os_versions
  embeds_many :os_last_comments

  private

  def set_infos

    if self.vendor.downcase.match"fedora"
      self.name = "fedora"
      self.url = "http://fedoraproject.org"
      self.logo = "fedoralogo.png"

    elsif self.vendor.downcase.match"ubuntu"
      self.name = "ubuntu"
      self.url = "http://ubuntu.com"
      self.logo = "ubuntulogo.png"
    
    elsif self.vendor.downcase.match"microsoft"
      self.name = "windows"
      self.url = "http://www.microsoft.com"
      self.logo = "windowsxp.jpg"
    

    elsif self.vendor.downcase.match"arch"
      self.name = "arch"
      self.url = "http://www.archlinux.org"
      self.logo = "archlinuxlogo.png"     
      
    elsif self.vendor.downcase.match"centos"
      self.name = "centos"
      self.url = "http://www.centos.org"
      self.logo = "centoslogo.png"

    elsif self.vendor.downcase.match"debian"
      self.name = "debian"
      self.url = "http://debian.org"
      self.logo = "debian.png"

    elsif self.vendor.downcase.match"mandriva"
      self.name = "mandriva"
      self.url = "http://www.mandriva.com"
      self.logo = "mandriva.png"
      
    elsif self.vendor.downcase.match"gentoo"
      self.name = "gentoo"
      self.url = "http://www.gentoo.org"
      self.logo = "gentoologo.jpg"
      
    elsif self.vendor.downcase.match"jolicloud"
      self.name = "jolicloud"
       self.url = "http://www.jolicloud.com"
       self.logo = "jolicloud.jpg"

    elsif self.name.downcase.match"mac"
      self.url = "http://www.apple.com"
      self.logo = "apple.png"
    end
    

  end

end
