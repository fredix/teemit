# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#######
# FEDORA
#######

fedora = Osystem.create(
                        :name => "fedora",
                        :vendor => "fedora",
                        :os_base => "unix",
                        :os_type => "linux",
                        :url => "http://fedoraproject.org",
                        :logo => "fedoralogo.png"
                        )

fedora.os_versions.create(
                         :vendor_code_name => "Yarrow",
                         :vendor_version => "Core 1",
                         :release_date => Date.new(2003, 11, 6),
                         :end_of_life => Date.new(2004, 9, 7)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Tettnang",
                         :vendor_version => "Core 2",
                         :release_date => Date.new(2004, 5, 18),
                         :end_of_life => Date.new(2005, 9 ,7)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Heidelberg",
                         :vendor_version => "Core 3",
                         :release_date => Date.new(2004, 11, 8),
                         :end_of_life => Date.new(2005, 9, 7)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Stentz",
                         :vendor_version => "Core 4",
                         :release_date => Date.new(2005, 6, 13),
                         :end_of_life => Date.new(2006, 9, 7)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Bordeaux",
                         :vendor_version => "Core 5",
                         :release_date => Date.new(2006, 3, 20),
                         :end_of_life => Date.new(2007, 9, 7)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Zod",
                         :vendor_version => "Core 6",
                         :release_date => Date.new(2006, 10, 20),
                         :end_of_life => Date.new(2007, 9, 7)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Moonshine",
                         :vendor_version => "7",
                         :release_date => Date.new(2007, 5, 30),
                         :end_of_life => Date.new(2008, 9, 7)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Werewolf",
                         :vendor_version => "8",
                         :release_date => Date.new(2007, 11, 8),
                         :end_of_life => Date.new(2008, 9, 7)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Sulphur",
                         :vendor_version => "9",
                         :release_date => Date.new(2008, 5,13),
                         :end_of_life => Date.new(2009, 9, 7)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Cambridge",
                         :vendor_version => "10",
                         :release_date => Date.new(2008, 11, 25),
                         :end_of_life => Date.new(2009, 9, 7)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Leonidas",
                         :vendor_version => "11",
                         :release_date => Date.new(2009, 6, 10),
                         :end_of_life => Date.new(2010, 6, 25)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Constantine",
                         :vendor_version => "12",
                         :release_date => Date.new(2009, 11, 17),
                         :end_of_life => Date.new(2010, 11, 29)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Goddard",
                         :vendor_version => "13",
                         :release_date => Date.new(2010, 5, 25)
                         )
fedora.os_versions.create(
                         :vendor_code_name => "Laughlin",
                         :vendor_version => "14",
                         :release_date => Date.new(2010, 11, 2)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Lovelock",
                         :vendor_version => "15",
                         :release_date => Date.new(2011, 05, 24)
                         )

fedora.os_versions.create(
                         :vendor_code_name => "Rawhide",
                         :vendor_version => ""
                         )

#######
# UBUNTU
#######


ubuntu = Osystem.create(
                        :name => "ubuntu",
                        :vendor => "ubuntu",
                        :os_base => "unix",
                        :os_type => "linux",
                        :url => "http://ubuntu.com",
                        :logo => "ubuntulogo.png"
                        )

ubuntu.os_versions.create(
                         :vendor_code_name => "The Warty Warthog",
                         :vendor_version => "4.10",
                         :release_date => Date.new(2004, 10, 20),
                         :end_of_life => Date.new(2006, 4, 30) 
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Hoary Hedgehog",
                         :vendor_version => "5.04",
                         :release_date => Date.new(2005, 4, 8),
                         :end_of_life => Date.new(2006, 4, 30)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Breezy Badger",
                         :vendor_version => "5.10",
                         :release_date => Date.new(2005, 10, 13),
                         :end_of_life => Date.new(2007, 4, 13)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Dapper Drake",
                         :vendor_version => "6.06",
                         :release_date => Date.new(2006, 6, 1),
                         :end_of_life_desktop => Date.new(2009, 6, 30),
                         :end_of_life_server => Date.new(2011, 6, 30)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Edgy Eft",
                         :vendor_version => "6.10",
                         :release_date => Date.new(2006, 10, 26),
                         :end_of_life => Date.new(2008, 4, 25)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Feisty Fawn",
                         :vendor_version => "7.04",
                         :release_date => Date.new(2007, 4, 19),
                         :end_of_life => Date.new(2008, 10, 19)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Gutsy Gibbon",
                         :vendor_version => "7.10",
                         :release_date => Date.new(2007, 10, 18),
                         :end_of_life => Date.new(2009, 4, 18)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Hardy Heron",
                         :vendor_version => "8.04",
                         :release_date => Date.new(2008, 4, 24),
                         :end_of_life_desktop => Date.new(2011, 4, 30),
                         :end_of_life_server => Date.new(2013, 4, 30)
                         )

ubuntu.os_versions.create(
                         :vendor_code_name => "The Intrepid Ibex",
                         :vendor_version => "8.10",
                         :release_date => Date.new(2008, 10, 30),
                         :end_of_life => Date.new(2010, 4, 30)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Jaunty Jackalope",
                         :vendor_version => "9.04",
                         :release_date => Date.new(2009, 4, 23),
                         :end_of_life => Date.new(2010, 10, 23)
                         )

ubuntu.os_versions.create(
                         :vendor_code_name => "The Karmic Koala",
                         :vendor_version => "9.10",
                         :release_date => Date.new(2009, 10, 29),
                         :end_of_life => Date.new(2011, 4, 30)
                         )
ubuntu.os_versions.create(
                         :vendor_code_name => "The Lucid Lynx",
                         :vendor_version => "10.04",
                         :release_date => Date.new(2010, 4, 29),
                         :end_of_life_desktop => Date.new(2013, 4, 30),
                         :end_of_life_server => Date.new(2015, 4, 30)
                         )

ubuntu.os_versions.create(
                         :vendor_code_name => "The Maverick Meerkat",
                         :vendor_version => "10.10",
                         :release_date => Date.new(2010, 10, 10),
                         :end_of_life => Date.new(2012, 4, 30)
                         )

ubuntu.os_versions.create(
                         :vendor_code_name => "The Natty Narwhal",
                         :vendor_version => "11.04",
                         :release_date => Date.new(2011, 4, 29),
                         :end_of_life => Date.new(2012, 10, 30)
                         )


#####
# ARCHLINUX
#####

arch = Osystem.create(
                      :name => "archlinux",
                      :vendor => "archlinux",
                      :os_base => "unix",
                      :os_type => "linux",
                      :url => "http://www.archlinux.org",
                      :logo => "archlinuxlogo.png"
                      )
arch.os_versions.create(
                      :vendor_code_name => "n/a",
                      :vendor_version => "n/a"
                      )



#######
# CENTOS
#######

centos = Osystem.create(
                        :name => "centos",
                        :vendor => "centos",
                        :os_base => "unix",
                        :os_type => "linux",
                        :url => "http://www.centos.org",
                        :logo => "centoslogo.png"
                        )
centos.os_versions.create(
                        :vendor_code_name => "Final",
                        :vendor_version => "5.5",
                        :release_date => "",
                        :end_of_life => ""
                         )
centos.os_versions.create(
                        :vendor_code_name => "Final",
                        :vendor_version => "5.4",
                        :release_date => "",
                        :end_of_life => ""
                         )

centos.os_versions.create(
                        :vendor_code_name => "Final",
                        :vendor_version => "5.3",
                        :release_date => "",
                        :end_of_life => ""
                         )

######
# DEBIAN
######


debian = Osystem.create(
                        :name => "debian",
                        :vendor => "debian",
                        :os_base => "unix",
                        :os_type => "linux",
                        :url => "http://debian.org",
                        :logo => "debian.png"
                        )
debian.os_versions.create(
                         :vendor_code_name => "Squeeze",
                         :vendor_version => "6.0.1"
                         )
debian.os_versions.create(
                         :vendor_code_name => "Squeeze",
                         :vendor_version => "6.0.2"
                         )
debian.os_versions.create(
                        :vendor_code_name => "Lenny",
                        :vendor_version => "5.0",
                         :release_date => Date.new(2010, 9, 4)
                         )
debian.os_versions.create(
                         :vendor_code_name => "Etch",
                         :vendor_version => "4.0",
                         :release_date => Date.new(2009, 4, 8),
                         :end_of_life => Date.new(2010, 2, 28)
                         )
debian.os_versions.create(
                         :vendor_code_name => "Sarge",
                         :vendor_version => "3.1",
                         :release_date => Date.new(2005, 6, 6),
                         :end_of_life => Date.new(2008, 3, 31)
                         )
debian.os_versions.create(
                         :vendor_code_name => "Woody",
                         :vendor_version => "3.0",
                         :release_date => Date.new(2002, 7, 19),
                         :end_of_life => Date.new(2006, 6, 30)
                         )

########
# MANDRIVA
########


mandriva = Osystem.create(
                          :name => "mandrivalinux",
                          :vendor => "mandriva",
                          :os_base => "unix",
                          :os_type => "linux",
                          :url => "http://www.mandriva.com",
                          :logo => "mandriva.png"
                          )
mandriva.os_versions.create(
                           :vendor_code_name => "Pauillac",
                           :vendor_version => "2009.1",
                           :release_date => Date.new(2005, 6, 6),
                           :end_of_life => Date.new(2007, 4, 8)
                           )

#####
# GENTOO
#####

gentoo = Osystem.create(
                        :name => "gentoo",
                        :vendor => "gentoo",
                        :os_base => "unix",
                        :os_type => "linux",
                        :url => "http://www.gentoo.org",
                        :logo => "gentoologo.jpg"
                        )
gentoo.os_versions.create(
                        :vendor_code_name => "n/a",
                        :vendor_version => "1.12.11.1"
                         )



#####
# JOLICLOUD
#####

jolicloud = Osystem.create(
                           :name => "Jolicloud",
                           :vendor => "Jolicloud",
                           :os_base => "unix",
                           :os_type => "linux",
                           :url => "http://www.jolicloud.com",
                           :logo => "jolicloud.jpg"
                           )
jolicloud.os_versions.create(
                            :vendor_code_name => "Robby",
                            :vendor_version => "alpha"
                            )



#########
# MICROSOFT
#########


windows = Osystem.create(
                         :name => "microsoft",
                         :vendor => "microsoft",
                         :os_base => "windows",
                         :os_type => "windows",
                         :url => "http://www.microsoft.com",
                         :logo => "microsoft.png"
                         )
windows.os_versions.create(
                         :vendor_code_name => "Seven",
                         :vendor_version => "7",
                         :release_date => Date.new(2009, 10, 6),
                         :end_of_life => Date.new(2015, 4, 8)
                          )
windows.os_versions.create(
                          :vendor_code_name => "Vista",
                          :vendor_version => "6",
                          :release_date => Date.new(2006, 10, 6),
                          :end_of_life => Date.new(2015, 4, 8)
                          )
windows.os_versions.create(
                          :vendor_code_name => "Whistler",
                          :vendor_version => "XP",
                          :release_date => Date.new(2001, 10, 6),
                          :end_of_life => Date.new(2011, 4, 8)
                          )
windows.os_versions.create(
                          :vendor_code_name => "98",
                          :vendor_version => "4",
                          :release_date => Date.new(2001, 10, 6),
                          :end_of_life => Date.new(2006, 4, 8)
                          )

#########
# APPLE
#########



macos = Osystem.create(
                       :name => "mac os x",
                       :vendor => "apple",
                       :os_base => "unix",
                       :os_type => "osx",
                       :url => "http://www.apple.com",
                       :logo => "apple.png"
                       )
macos.os_versions.create(
                        :vendor_code_name => "Snow Leopard",
                        :vendor_version => "10.6"
                        )
macos.os_versions.create(
                        :vendor_code_name => "Leopard",
                        :vendor_version => "10.5"
                        )
macos.os_versions.create(
                        :vendor_code_name => "Tiger",
                        :vendor_version => "10.4"
                        )
