class ReportController < ApplicationController
  #caches_page :uptime, :load, :memory, :network, :cpu, :processus


  def all
    @hosts_all = Host.count
    @hosts_publics = Host.count(:conditions => {"public" => true, "blocked" => false})

    @users_all = User.count
    @users_publics = User.count(:conditions => {"public" => true, "blocked" => false})
  end

  def country
    if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return      
    elsif params[:id] == 'all'
      @group_by_countries = User.group_by_country

      return     
    else
      @country = params[:id].downcase
     @users = User.is_public.where(:country => @country.downcase).page(params[:page])

      if @users.empty?
        flash[:warning] = I18n.t(:host_not_found)
        # redirect_to :back
        redirect_back_or_default(:controller => '/main', :action => 'index')
        # redirect_to :controller => :main
        return      
      else
        @users_count_public = User.count(:conditions => {:country => @country.downcase, :public => true, :blocked => false, :confirmed_at.ne => nil})

        render :template => 'report/filter_on_user'
      end
    end
  end



  def city
    if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    elsif params[:id] == 'all'
      @group_by_cities = User.group_by_city    

     return
    else
      @city = params[:id].downcase
     @users = User.is_public.where(:city => @city.downcase).page(params[:page])


      if @users.empty?
        flash[:warning] = I18n.t(:host_not_found)
        redirect_to :controller => :main
        return      
      else
        @users_count_public = User.count(:conditions => {:city => @city.downcase, :public => true, :blocked => false, :confirmed_at.ne => nil})

        render :template => 'report/filter_on_user'
      end
    end
  end
 

  def plateform
   if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return

   elsif params[:id] == 'all'
     @group_by_architecture = Host.only(:architecture).aggregate

     render :template => 'report/os_plateform'
     return
    else
     @plateform = params[:id].downcase
     @hosts = Host.is_public.where(:architecture => @plateform.downcase).page(params[:page])


     if @hosts.empty?
       flash[:warning] = I18n.t(:host_not_found)
       redirect_to :controller => :main
       return      
     else

       @hosts_count_public_os = Host.count(:conditions => {:architecture => @plateform.downcase, :public => true, :blocked => false})

       render :template => 'report/distribution'
     end
   end
  end


  def os
   if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return

   elsif params[:id] == 'all'

#    @hosts_count_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :group => "lower(osystems.name)", :order => "lower(osystems.name) ASC")

 #   @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :group => "lower(osystems.name)", :order => "lower(osystems.name) ASC", :conditions => "public is TRUE and blocked is FALSE")

     # @osystems = Osystem.where(:counter.gt => 0)

     os_stats = Osystem.only(:vendor).where(:hosts_number.gt => 0).group

     @osystems = []


     os_stats.each do | os |
        count = 0
        vendor = ''
        os['group'].each {| a | vendor = a.vendor ; count += a.hosts_number }
        @osystems.push( {:vendor => vendor, :count => count} )
      end



     # @group_by_architecture = Host.only(:architecture).aggregate



=begin
     count=0
     @osystems.each do |os|
        var = "#{@os}#{count}"
        var.eval = []
        var.eval.push( Array[os.created_at.to_time.to_i*1000, os.name] )
      end
=end


     #    @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :group => "lower(osystems.name)", :conditions => "hosts.public is TRUE")

    else
    @os = params[:id]

    #    systems = Osystem.find(:all, :select => "id", :conditions => "lower(name) = '#{params[:id]}'")
    #   logger.info systems.class

     # @hosts = Host.paginate(:per_page => 5, :page => params[:page], :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :conditions => "lower(osystems.name) = '#{@os}' AND public is TRUE and blocked is FALSE", :order => "hosts.uptime DESC")

     osystems = Osystem.where(:vendor => @os.downcase)
     osysid = []
     osystems.each {|os| osysid.push(os.id)}


     

     logger.info "OSYSID : #{osysid.inspect}"

=begin
     if !osystem
       flash[:warning] = I18n.t(:host_not_found)
       redirect_to :controller => :main
       return      
     end
=end

     @hosts = Host.is_public.where(:osystem_id.in => osysid).page(params[:page])


     if @hosts.empty?
       flash[:warning] = I18n.t(:host_not_found)
       redirect_to :controller => :main
       return      
     else

#       @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :group => "lower(osystems.name)", :order => "lower(osystems.name) ASC", :conditions => "lower(osystems.name) = '#{@os}' and public is TRUE and blocked is FALSE")

       #  @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :conditions => "lower(osystems.name) = '#{@os}' AND hosts.public is TRUE")


       # @hosts_count_public_os = Host.count(:conditions => {:osystem_id => osystem.id, :public => true, :blocked => false})


       render :template => 'report/distribution'
     end
   end
  end


  def uptimes
    @hosts_count = Host.count(:conditions => {"public"=> true , "blocked" => false})

#    @max = UptimeStatistic.max(:time) / 3600 / 24

=begin
    @pager = Paginator.new(@hosts_count, 20) do |offset, per_page|
      Host.all(:offset => offset, :limit => per_page, :conditions => {"public"=>true , "blocked" => false}, :order => 'hosts.uptime DESC')
    end
    @hosts = @pager.page(params[:page])
=end


    # @hosts = Host.paginate(:per_page => 5, :page => params[:page], :conditions => {:public => true, :blocked => false}, :sort => [["stats_uptime.time", :desc]])    
    @hosts = Host.is_public.page(params[:page])    


    if @hosts.length == 0
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return      
    else

      #       @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :group => "lower(osystems.name)", :order => "lower(osystems.name) ASC", :conditions => "lower(osystems.name) = '#{@limit}' and public is TRUE and blocked is FALSE")

      #   @hosts_count_os = Host.count(:all, :group => "hosts.uptime", :order => "hosts.uptime DESC", :limit => 10)

#      @hosts_count_public_os = {}

      @hosts_count_public_os = Host.count(:conditions => {"public" => true, "blocked" => false})

      #  @hosts_count_public_os = Host.count(:all, :joins => "INNER JOIN osystems ON osystems.id = hosts.osystem_id", :conditions => "lower(osystems.name) = '#{@limit}' AND hosts.public is TRUE")

    end
  end




  def memory
    if params[:uuid] and current_user
      # find on private uuid
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end


    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_memory
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end


    if !Rails.cache.exist?("views/report/memory/#{@host.uuid}")


      @mem_used = Array.new
      @mem_free = Array.new
      @mem_actual_free = Array.new
      @mem_actual_used = Array.new
      @mem_actual_free_percent = Array.new
      @mem_actual_used_percent = Array.new
      
      @swap_used = Array.new
      @swap_free = Array.new
      @swap_page_in = Array.new
      @swap_page_out = Array.new


      #    @datas = @host.memory_statistics.all.order_by(:created_at)

      @datas = @host.memory_statistics.three_days_ago_before_last(@host)


    
=begin
    if @datas.empty?
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    else
      # @puser = User.find(@datas.first.user_id)
      @puser = @host.user
    end
=end



      @datas.each do |data|
        @mem_used.push( Array[data.created_at.to_time.to_i*1000, data.mem_used] )
        @mem_free.push( Array[data.created_at.to_time.to_i*1000, data.mem_free] )
        @mem_actual_free.push( Array[data.created_at.to_time.to_i*1000, data.mem_actual_free] )
        @mem_actual_used.push( Array[data.created_at.to_time.to_i*1000, data.mem_actual_used] )
        @mem_actual_free_percent.push( Array[data.created_at.to_time.to_i*1000, data.mem_actual_free_percent] )
        @mem_actual_used_percent.push( Array[data.created_at.to_time.to_i*1000, data.mem_actual_used_percent] )
        
        @swap_used.push( Array[data.created_at.to_time.to_i*1000, data.swap_used] )
        @swap_free.push( Array[data.created_at.to_time.to_i*1000, data.swap_free] )
        @swap_page_in.push( Array[data.created_at.to_time.to_i*1000, data.swap_page_in] )
        @swap_page_out.push( Array[data.created_at.to_time.to_i*1000, data.swap_page_out] )
      end
    end
  end




  def network
    if params[:uuid] and current_user
      # find on private uuid
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      # @host = Host.find_by_pub_uuid(params[:id])
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end

    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_network
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end


    if !Rails.cache.exist?("views/report/network/#{@host.uuid}")

      @rx_rate = Array.new
      @tx_rate = Array.new

      # @network = @host.network_statistics.all.order_by(:created_at)

      @network = @host.network_statistics.three_days_ago_before_last(@host)


=begin
    if @network.empty?
      flash[:warning] = I18n.t(:no_data)
      # redirect_to :controller => :main 
      # return
    # else
      # @puser = User.find(@datas.first.user_id)
      # @puser = @host.user
    end
=end
    
      @network.each do |network|
        @rx_rate.push( Array[network.created_at.to_time.to_i*1000, network.rx_rate] )
        @tx_rate.push( Array[network.created_at.to_time.to_i*1000, network.tx_rate] )
      end
    end
  end



  def cpu
    if params[:uuid] and current_user
      # find on private uuid
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      # @host = Host.find_by_pub_uuid(params[:id])
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end

    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_cpu
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end

    if !Rails.cache.exist?("views/report/cpu/#{@host.uuid}")

      @cpu_user = Array.new
      @cpu_sys = Array.new
      @cpu_nice = Array.new
      @cpu_idle = Array.new
      @cpu_wait = Array.new
      @cpu_irq = Array.new
      @cpu_soft_irq = Array.new
      @cpu_stolen = Array.new
      @cpu_combined = Array.new
      @cpu_total = Array.new

      # @cpu = @host.cpu_statistics.all.order_by(:created_at)

      @cpu = @host.cpu_statistics.three_days_ago_before_last(@host)


=begin
    if @cpu.empty?
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    else
      # @puser = User.find(@datas.first.user_id)
      @puser = @host.user
    end
=end

    
      @cpu.each do |cpu|
        @cpu_user.push( Array[cpu.created_at.to_time.to_i*1000, cpu.user] )
        @cpu_sys.push( Array[cpu.created_at.to_time.to_i*1000, cpu.sys] )
        @cpu_nice.push( Array[cpu.created_at.to_time.to_i*1000, cpu.nice] )
        @cpu_idle.push( Array[cpu.created_at.to_time.to_i*1000, cpu.idle] )
        @cpu_wait.push( Array[cpu.created_at.to_time.to_i*1000, cpu.wait] )
        @cpu_irq.push( Array[cpu.created_at.to_time.to_i*1000, cpu.irq] )
        @cpu_soft_irq.push( Array[cpu.created_at.to_time.to_i*1000, cpu.soft_irq] )
        @cpu_stolen.push( Array[cpu.created_at.to_time.to_i*1000, cpu.stolen] )
        @cpu_combined.push( Array[cpu.created_at.to_time.to_i*1000, cpu.combined] )
        @cpu_total.push( Array[cpu.created_at.to_time.to_i*1000, cpu.total] )
      end
    end
  end






  def load
    if params[:uuid] and current_user
      # find on private uuid
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end



    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_load
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end


    if !Rails.cache.exist?("views/report/load/#{@host.uuid}")

      @loadavg0 = Array.new
      @loadavg1 = Array.new
      @loadavg2 = Array.new

      @load = @host.load_statistics.three_days_ago_before_last(@host)

=begin
    if @load.empty?
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    else
      # @puser = User.find(@datas.first.user_id)
      @puser = @host.user
    end
=end
    
      @load.each do |load|
        @loadavg0.push( Array[load.created_at.to_time.to_i*1000, load.loadavg0] )
        @loadavg1.push( Array[load.created_at.to_time.to_i*1000, load.loadavg1] )
        @loadavg2.push( Array[load.created_at.to_time.to_i*1000, load.loadavg2] )
      end
    end
end




  def uptime
    if params[:uuid] and current_user
      # find on private uuid
      # @host = current_user.hosts.first(:conditions => {:uuid => params[:uuid]})
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      # @host = Host.find_by_pub_uuid(params[:id])
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end

    
    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_uptime
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end


    if !Rails.cache.exist?("views/report/uptime/#{@host.uuid}")

      @datas = Array.new  

      # @uptime = @host.uptime_statistics.criteria.all.order_by([[:created_at, :asc]])

      @uptime = @host.uptime_statistics.three_days_ago_before_last(@host)

      @uptime.each do |hs|
        # @uptime.push( Array[hs.created_at.to_time.to_i*1000, hs.uptime.to_f] )
        @datas.push( Array[hs.created_at.to_time.to_i*1000, hs.time / 3600] )
        # WTF
        #      if hs.public and !current_user.hosts.find_by_pub_uuid(hs.pub_uuid)
        #          @datas.delete(hs) if !current_user.hosts.include?(hs) 
        #       @datas = []
        #     break
        #  end
      end
    end
    render :template => "/report/flot"
  end





  def processus
    if params[:uuid] and current_user
      # find on private uuid
      # @host = current_user.hosts.first(:conditions => {:uuid => params[:uuid]})
      @host = Host.first(:conditions => {:user_id => current_user.id, :uuid => params[:uuid]})
    elsif params[:id]
      # find on public uuid
      # @host = Host.find_by_pub_uuid(params[:id])
      @host = Host.first(:conditions => {:pub_uuid => params[:id], :public => true})
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end

    if !@host
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main 
      return
    end


    @puser = @host.user
    if !@host.stats_process
      #flash[:warning] = I18n.t(:data_not_found)
      render :template => 'report/empty'
      return
    end

    if !Rails.cache.exist?("views/report/processus/#{@host.uuid}")
      @last_stat = @host.process_statistics.desc(:created_at).limit(1).first
    end

  end












  def scruffy
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "line_test.svg"
    graph.render  :width => 300, :height => 200,
      :to => "line_test.png", :as => 'png'


  end


  def gruff_test
    g = Gruff::Line.new
    g.title = "My Graph" 

    g.data("Apples", [1, 2, 3, 4, 4, 3])
    g.data("Oranges", [4, 8, 7, 9, 8, 9])
    g.data("Watermelon", [2, 3, 1, 5, 6, 8])
    g.data("Peaches", [9, 9, 10, 8, 7, 9])

    g.labels = {
      0 => '2001', 2 => '2004', 4 => '2005',
      6 => '2006', 8 => '2008', 10 => '2010',
      12 => '2012', 14 => '2014', 16 => '2016'
    }


    send_data(g.to_blob, 
              :disposition => 'inline', 
              :type => 'image/png', 
              :filename => "#{current_user.login}_uptime_chart.png")


  end


  def gruff
    if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end

    uptime = Array.new
    g = Gruff::Line.new(400)
    g.title = "Uptime chart"
    g.font = File.expand_path('artwork/fonts/Vera.ttf', RAILS_ROOT)

    g.theme = {
      :colors => ['#ff6600', '#3bb000', '#1e90ff', '#efba00', '#0aaafd'],
      :marker_color => '#aaa',
      :background_colors => ['#eaeaea', '#fff']
    }


    g.labels = { 
      0 => 'Jan', 59 => 'Fev', 90 => 'Mars', 120 => 'Avril' , 
      150 => 'Mai', 180 => 'Juin', 210 => 'Juillet', 241 => 'Aout' , 
      271 => 'Septembre', 301 => 'Octobre', 332 => 'Novembre', 365 => 'Decembre'
    }
    

    params[:id] = nil if !params[:id]

    # Modify this to represent your actual data models

#    @data = current_user.hosts.each do |host|

#    @data = current_user.hosts.find(:id, :select => ['host_statistics.pub_uuid', 'host_statistics.uptime', 'host_statistics.created_at'], :include => :host_statistics)

#    @data = HostStatistics.find(:all, :select => "host.pub_uuid, host_statistics.pub_uuid, host_statistics.uptime, host_statistics.created_at",   :joins => "left outer join host_statistics on host_statistics.id = host.id")


    if current_user 

      @datas = HostStatistic.find(:all, :select => "hosts.hostname, hosts.public, users.login as login, users.id as user_id, hosts.pub_uuid, host_statistics.id, host_statistics.host_id, host_statistics.uptime, host_statistics.created_at", :joins => "inner join hosts on hosts.id = host_statistics.host_id inner join users on users.id=hosts.user_id", :conditions => "hosts.pub_uuid='#{params[:id]}'", :order => "host_statistics.created_at")

      @datas.each do |hs|
        # WTF
        if hs.public == 'f' and !current_user.hosts.find_by_pub_uuid(hs.pub_uuid)
          #          @datas.delete(hs) if !current_user.hosts.include?(hs) 
          @datas = []
            break
        end
      end
    else

      @datas = HostStatistic.find(:all, :select => "hosts.hostname, hosts.public, users.login as login, users.id as user_id, hosts.pub_uuid, host_statistics.id, host_statistics.uptime, host_statistics.created_at", :joins => "inner join hosts on hosts.id = host_statistics.host_id inner join users on users.id=hosts.user_id", :conditions => "hosts.pub_uuid='#{params[:id]}' AND hosts.public is TRUE and blocked is FALSE", :order => "host_statistics.created_at")


    end


    if @datas.empty?
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    else
      @host = Host.find_by_pub_uuid(params[:id])
      @puser = User.find(@datas.first.user_id)
    end



    @datas.each do |d|
      # Build data into array with something like
#      p d.uptime.class
      p d.inspect
      #built_array = d.collect { |e| e.uptime.to_f }
#      g.data(d.pub_uuid, d.uptime.to_f.round / 24)
      

      uptime.push(d.uptime.to_f.round / 24)
      p d.uptime.to_f.round 
    end

    logger.info uptime.inspect

    g.data("#{@datas.first.hostname}@#{@datas.first.login}", uptime)

    @uuid = @datas.first.pub_uuid

=begin
      send_data(g.to_blob, 
                :disposition => 'inline', 
                :type => 'image/png', 
                :filename => "#{@uuid}_uptime_chart.png")
=end



    g.write("#{RAILS_ROOT}/public/images/uptime/#{@uuid}_uptime_chart.png")


  end



end
