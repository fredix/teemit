class UsersController < ApplicationController
  # before_filter :require_no_user, :only => [:new, :create]
  # before_filter :require_user, :only => [:edit, :update, :settings, :profils, :delete]

  before_filter :authenticate_user!, :only => [:edit, :update, :settings, :profils, :delete]


  def public
    @users_count = User.count(:conditions => {:public => true , :blocked => false, :confirmed_at.ne => nil})

    if @users_count != 0
      @users = User.is_public.page params[:page]   
    else
      @users = []
    end


=begin
    @pager = Paginator.new(@users_count, 20) do |offset, per_page|
      User.find(:all, :offset => offset, :limit => per_page, :conditions => {"public"=>true}, :order => 'created_at DESC')
    end
    @users = @pager.page(params[:page])
=end


  end
  
  def new
    @user = User.new
  end
   

  def create
    if params[:user]
      @user = User.new(params[:user])
      @user.pub_uuid = generate_uuid
      @user.save
      
      # @user.save do |result|
      # if result
      flash[:notice] = I18n.t(:account_registered)
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  

  def hosts
    if params[:user]
      @user = User.first(:conditions => {:login => params[:user].downcase, :public => true})
      if !@user
        @user = User.first(:conditions => {:pub_uuid => params[:user].downcase, :public => true})
      end
      if !@user
        flash[:warning] = I18n.t(:unknow_user)
        redirect_to :controller => :main 
        return
      end
      @hosts_count = @user.public_hosts_number
      @hosts = @user.hosts.is_public.page params[:page]
    else
      flash[:warning] = I18n.t(:unknow_user)
      redirect_to :controller => :main
      return
    end
    
  end

  def show
    if !params[:id]
      @user = current_user
    else
      @user = User.find_by_pub_uuid(params[:id], :conditions => {:public => true})
    end
    
    if !@user
      flash[:warning] = I18n.t(:unknow_user)
      redirect_to :controller => :main 
    end
  end


  def nickname
    if !params[:user]
      @user = current_user
    else
      @user = User.first(:conditions => {:login => params[:user].downcase, :public => true})

      # we use public uuid if user haven't login
      if !@user
        @user = User.first(:conditions => {:pub_uuid => params[:user].downcase, :public => true}) 
      end
    end
    
    if !@user
      flash[:warning] = I18n.t(:unknow_user)
      redirect_to :controller => :main 
      return
    end

    render :show
  end



 
  def edit
    @user = current_user
  end
  
  def settings
    @user = current_user

    if params[:users]
      @current_user.api_key = generate_uuid
      @current_user.save
    end
  end


  def delete
    current_user.hosts.each do |host|
      host.destroy
    end

    current_user.profils.each do |profil|
      profil.destroy
    end


    current_user.delete
    redirect_to "/"
  end


  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end



end
