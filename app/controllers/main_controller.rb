class MainController < ApplicationController

  def index 
    @hosts_all = Host.count
    @hosts_publics = Host.count(:conditions => {:public => true,  :blocked => false})
  end

  def contact
  end

end
