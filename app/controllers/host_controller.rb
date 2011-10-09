class HostController < ApplicationController
#  before_filter :require_user, :except => [:public, :show]
  before_filter :authenticate_user!, :except => [:public, :show]


  def public
    @hosts_count = Host.count(:conditions => {"public"=> true , "blocked" => false})

    if @hosts_count != 0
      # @hosts = Host.paginate(:per_page => 5, :page => params[:page], :conditions => {:public => true, :blocked => false}, :order => "updated_at DESC")    

      @hosts = Host.is_public.page params[:page]
    else
      @hosts = []
    end


  end

  def mine
    @hosts_count = current_user.hosts.count
    logger.info "COUNT = #{@hosts_count}"
    @hosts = current_user.hosts.page(params[:page])   
  end


  def block
    if params[:id]
      host = Host.first(:conditions => {:uuid => params[:id]})
      
      logger.info "HOST : #{host.inspect}"

      if current_user and host.user == current_user

        host.update_attributes({:blocked => true})
      
        # host.blocked = true
        # host.save
      else
        flash[:warning] = I18n.t(:host_not_found)
        redirect_to :controller => :main
        return
      end
      redirect_to :action => :mine
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end
  end


  def unblock
    if params[:id]
      host = Host.first(:conditions => {:uuid => params[:id]})
      
      if current_user and host.user == current_user
        host.blocked = false
        host.save
      else
        flash[:warning] = I18n.t(:host_not_found)
        redirect_to :controller => :main
        return
      end
      redirect_to :action => :mine
    else
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    end
  end



  def edit
    if !params[:id]
      flash[:warning] = I18n.t(:host_not_found)
      redirect_to :controller => :main
      return
    else
      @host = Host.where(:pub_uuid => params[:id]).first       
      if !@host
        flash[:warning] = I18n.t(:host_not_found)
        redirect_to :controller => :main
        return
      end
    end
  end


  def update
    respond_to do |format|
      format.html{
        @host = Host.where(:pub_uuid => params[:id]).first       

        if current_user.hosts.include?(@host)
          # @host.update_attributes(params[:host])
          @host.avatar = params[:host][:avatar]
          @host.description = params[:host][:description]
          #u.avatar = File.open('somewhere')
          @host.save!
          
          flash[:notice] = "Host updated"
          redirect_to host_url
        else
          flash[:warning] = I18n.t(:unknow_host)
          redirect_to :controller => :main
          return
        end
      }
    end
  end



  def show
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

    #if stale?(:last_modified => @host.updated_at.utc, :etag => @host)
      respond_to do |format|
        format.html{
          if !@host or (!@host.public && current_user && !current_user.profils.first.hosts.include?(@host))
            flash[:warning] = I18n.t(:host_not_found)
            redirect_to :controller => :main
          else
            @puser = @host.user
          end
        }
        format.xml{
          if @host
            render :xml => @host , :status => :ok, :location => url_for(@host.pub_uuid)
          else
            render :text => '<xml><error>Host not found</error></xml>', :status => :not_found
          end
        }
    end
    #end
  end

=begin
  def create
    respond_to do |format|
      format.html
      format.json{
        # render :json => Object.create(:user => @current_user, :foo => params[:foo], :bar => params[:bar])
      }
      format.xml{
#        render :xml => Object.create(:user => @current_user, :foo => params[:foo], :bar => params[:bar])


        # host = Host.first(:conditions => {:uuid => params[:host][:uuid]})
        
        # if !host
        
          # logger.info "HOOOOOOST : #{host.class}"

#=begin
        @host = Host.find_by_uuid(params[:host][:uuid])
        os = Osystem.find(:all, :conditions => "lower(name) = '#{params[:host][:os_name].downcase}' AND lower(codename) LIKE '%#{params[:host][:os_codename].downcase}%' AND version LIKE '%#{params[:host][:os_release]}%' AND computer_architecture = '#{params[:host][:architecture]}'")

        if os.length != 0
          if !@host

#=end

        push_host = {
          :public => params[:host][:public], 
          :version => params[:host][:version], 
          :patch_level => params[:host][:patch_level].nil? ? "" : params[:host][:patch_level].downcase, 
          :cpu_vendor => params[:host][:cpu_vendor], 
          :architecture => params[:host][:architecture],
          :cpu_model => params[:host][:cpu_model], 
          :cpu_mhz => params[:host][:cpu_mhz],
          :cpu_cache_size => params[:host][:cpu_cache_size], 
          :cpu_number => params[:host][:cpu_number],
          :cpu_total_cores => params[:host][:cpu_total_cores], 
          :cpu_total_sockets => params[:host][:cpu_total_sockets],
          :cpu_cores_per_socket => params[:host][:cpu_cores_per_socket], 
          :mem_ram => params[:host][:mem_ram],
          :mem_total => params[:host][:mem_total], 
          :hostname => params[:host][:hostname],
          :domain_name => params[:host][:domain_name], 
          :default_gateway => params[:host][:default_gateway],
          :primary_dns => params[:host][:primary_dns], 
          :secondary_dns => params[:host][:secondary_dns],
          :primary_interface => params[:host][:primary_interface], 
          :primary_addr => params[:host][:primary_addr], 
          :user_id => current_user.id
        }


        host_uptime = {
          :time => params[:host][:uptime_time],
          :days => params[:host][:uptime_days]
        }

        host_load = {
          :loadavg0 => params[:host][:loadavg0],
          :loadavg1 => params[:host][:loadavg1],
          :loadavg2 => params[:host][:loadavg2]
        }


        host_mem = {
          :mem_used => params[:host][:mem_used],
          :mem_free => params[:host][:mem_free],
          :mem_actual_free => params[:host][:mem_actual_free],
          :mem_actual_used => params[:host][:mem_actual_used],
          :mem_actual_free_percent => params[:host][:mem_actual_free_percent],
          :mem_actual_used_percent => params[:host][:mem_actual_used_percent],
          :swap_total => params[:host][:swap_total],
          :swap_used => params[:host][:swap_used],
          :swap_free => params[:host][:swap_free],
          :swap_page_in => params[:host][:swap_page_in],
          :swap_page_out => params[:host][:swap_page_out]
        }


        host_network = {
          :rx_rate => params[:host][:rx_rate],
          :tx_rate => params[:host][:tx_rate]
        }


        host_cpu = {
          :user => params[:host][:cpu_user],
          :sys => params[:host][:cpu_sys],
          :nice => params[:host][:cpu_nice],
          :idle => params[:host][:cpu_idle],
          :wait => params[:host][:cpu_wait],
          :irq => params[:host][:cpu_irq],
          :soft_irq => params[:host][:cpu_soft_irq],
          :stolen => params[:host][:cpu_stolen],
          :combined => params[:host][:cpu_combined],
          :total => params[:host][:cpu_total]
        }


            begin
              # @host = current_user.find("profil.context" => "default").hosts.create(push_host)


              # profil = current_user.profil.first

              # @host = current_user.profils.first.hosts.create(push_host)

              profil = current_user.profils.first(:conditions => {"context" => params[:host][:profil]})

              if !profil
                profil = current_user.profils.create(:context  => params[:host][:profil])
              end

              @host = profil.hosts.create(push_host)


              osystem = Osystem.first(:conditions => 
                                      {
                                        "vendor" => params[:host][:vendor].downcase,
                                        "vendor_version" => params[:host][:vendor_version].downcase
                                      }
                                      )

              if !osystem
                osystem = Osystem.create(
                                         :name => params[:host][:name].downcase,
                                         :vendor => params[:host][:vendor].downcase,
                                         :vendor_version => params[:host][:vendor_version].downcase,
                                         :vendor_code_name => params[:host][:vendor_code_name].nil? ? "" : params[:host][:vendor_code_name].downcase,
                                         :description => params[:host][:description],                                          
                                         :os_base => params[:host][:os_base], 
                                         :os_type => params[:host][:os_type]
                                         )
              end

                @host.osystem_id = osystem.id
                osystem.hosts_number += 1
                osystem.save
                @host.save


              
              if params[:host][:activated_memory] == "true"
                @host.memory_statistics.create(host_mem)
              end

              if params[:host][:activated_load] == "true"
                @host.load_statistics.create(host_load)
              end

              if params[:host][:activated_uptime] == "true"
                @host.uptime_statistics.create(host_uptime)
              end

              if params[:host][:activated_network] == "true"
                @host.network_statistics.create(host_network)
              end

              if params[:host][:activated_cpu] == "true"
                @host.cpu_statistics.create(host_cpu)
              end

              # @host.host_statistics.create(:osystem_id => os.first.id, :uptime => params[:host][:uptime])

            rescue => e
              logger.info "error on create host : #{e}"
              render :xml => @host.errors.full_messages , :status => :unprocessable_entity
              return
            end

            current_user.hosts_number += 1
            current_user.save

            logger.info host_url(@host)

        # render :xml => @host , :status => :created, :location => url_for(@host.pub_uuid)
          #  render :xml => @host, :status => :created, :location => "/main"
        render :xml => "<xml><uuid>#{@host.uuid}</uuid></xml>"
            return
#          else
#            render :xml => @host.errors.full_messages, :status => :conflict
#            return
#          end
#        else
#          render :text => '<xml><error>Operating system not found</error></xml>' 
#          return
 #       end


#=begin
        if (@key = params[:api])
          user = User.find_by_api_key(@key)

          if user
            p params[:datas]       
            #        @user.hst.create(params[:datas]
          end
        else
          p "NOK"
        end
#=end


        #else
         # render :text => '<xml><error>Host exist</error></xml>' 
         # return
        #end
      }
    end



  end


  def update
    respond_to do |format|
      format.html{
        @host = Host.find_by_pub_uuid(params[:id])       

        if current_user.hosts.include?(@host)
          # @host.update_attributes(params[:host])
          @host.avatar = params[:host][:avatar]
          #u.avatar = File.open('somewhere')
          @host.save!

          flash[:notice] = "Host updated"
          redirect_to host_url
        else
          flash[:warning] = I18n.t(:unknow_host)
          redirect_to :controller => :main
          return
        end
      }
      format.json{
        # render :json => Object.create(:user => @current_user, :foo => params[:foo], :bar => params[:bar])
      }
      format.xml{
        logger.info("UPDATE PARAMS = #{params.inspect}")

        # @host = Host.find_by_uuid(params[:host][:uuid], :conditions => "blocked=false")       

        @host = Host.first(:conditions => {:uuid => params[:id], :blocked => false})


        logger.info "NB HOST : #{current_user.hosts.length}"

        if !@host
          logger.info "404"
          render :text => '<xml><error>Host unknown</error></xml>' , :status => "404"
        elsif current_user.hosts.include?(@host)
          # os = Osystem.find(:all, :conditions => "lower(name) = '#{params[:host][:os_name].downcase}' AND lower(codename) LIKE '%#{params[:host][:os_codename].downcase}%' AND version = '#{params[:host][:os_release]}' AND computer_architecture = '#{params[:host][:architecture]}'")


          host_uptime = {
            :time => params[:host][:uptime_time],
            :days => params[:host][:uptime_days]
          }

          host_load = {
            :loadavg0 => params[:host][:loadavg0],
            :loadavg1 => params[:host][:loadavg1],
            :loadavg2 => params[:host][:loadavg2]
          }


          host_mem = {
            :mem_used => params[:host][:mem_used],
            :mem_free => params[:host][:mem_free],
            :mem_actual_free => params[:host][:mem_actual_free],
            :mem_actual_used => params[:host][:mem_actual_used],
            :mem_actual_free_percent => params[:host][:mem_actual_free_percent],
            :mem_actual_used_percent => params[:host][:mem_actual_used_percent],
            :swap_total => params[:host][:swap_total],
            :swap_used => params[:host][:swap_used],
            :swap_free => params[:host][:swap_free],
            :swap_page_in => params[:host][:swap_page_in],
            :swap_page_out => params[:host][:swap_page_out]
          }


        host_network = {
          :rx_rate => params[:host][:rx_rate],
          :tx_rate => params[:host][:tx_rate]
        }

        host_cpu = {
          :user => params[:host][:cpu_user],
          :sys => params[:host][:cpu_sys],
          :nice => params[:host][:cpu_nice],
          :idle => params[:host][:cpu_idle],
          :wait => params[:host][:cpu_wait],
          :irq => params[:host][:cpu_irq],
          :soft_irq => params[:host][:cpu_soft_irq],
          :stolen => params[:host][:cpu_stolen],
          :combined => params[:host][:cpu_combined],
          :total => params[:host][:cpu_total]
        }


          # @host.update_attributes( push_host)         
          # @host.host_statistics.create(:osystem_id => os.first.id, :uptime => params[:host][:uptime])

          # check if new profil is push.

          if params[:host][:profil] != @host.profil.context
            profil = current_user.profils.first(:conditions => {"context" => params[:host][:profil]})
            if !profil
              profil = current_user.profils.create(:context  => params[:host][:profil])
            end
            @host.profil = profil           
            @host.save
          end

          # check if privacy host changed
          if params[:host][:public] != @host.public
            @host.public = params[:host][:public]
            @host.save
          end



          if params[:host][:activated_memory] == "true"
            @host.memory_statistics.create(host_mem)
          end

          if params[:host][:activated_load] == "true"
            @host.load_statistics.create(host_load)
          end

          if params[:host][:activated_uptime] == "true"
            @host.uptime_statistics.create(host_uptime)
          end

          if params[:host][:activated_network] == "true"
            @host.network_statistics.create(host_network)
          end

          if params[:host][:activated_cpu] == "true"
            @host.cpu_statistics.create(host_cpu)
          end

          # render :xml => @host, :status => :accepted, :location => url_for(@host.uuid)
          render :xml => @host, :status => :accepted, :location => "/main"

        else
          logger.info "unauthorized update"
          render :text => '<xml><error>Host error</error></xml>' , :status => :unauthorized
        end
      }
    end
  end
=end

  def delete
    if params[:id]
      host = Host.first(:conditions => {:uuid => params[:id]})

      host.destroy if current_user and current_user.hosts.include?(host)

      redirect_to "/hosts"
    end
  end


end
