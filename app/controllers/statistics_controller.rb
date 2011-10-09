class StatisticsController < ApplicationController

  def index
    @hosts = Host.find(:all, :conditions => "public=true")     
  end

end
