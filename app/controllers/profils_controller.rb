class ProfilsController < ApplicationController
  before_filter :authenticate_user!


  def list
    @user = current_user
#    @profils = Profil.owner(@user.id).order_by_created
    @profils = @user.profils
  end

  def add
  end

  def edit
    if params[:id]
      begin
        @profil = Profil.criteria.id(BSON::ObjectID.from_string(params[:id])).first       
      rescue => e
        flash[:warning] = I18n.t(:profil_not_found)      
        redirect_to :action => :list
      end
      return
    else
      flash[:warning] = I18n.t(:profil_not_found)
      redirect_to :action => :list      
    end
  end

  def create 
    if params[:profil]
      Profil.create(
                    :user_id => current_user.id,
                    :nickname => params[:profil][:nickname],
                    :email => params[:profil][:email],
                    :context => params[:profil][:context],
                    :public => params[:profil][:public].nil? ? false : true
                    )    
    end
    redirect_to :action => :list
    return
  end


  def update
    if params[:profil]
      begin
        # profil = Profil.find(params[:profil][:id])
        profil = Profil.criteria.id(BSON::ObjectID.from_string(params[:profil][:id])).first       
      rescue
        flash[:warning] = I18n.t(:profil_not_found)
        redirect_to :action => :list
      end
      profil.update_attributes(
                               # :user_id => current_user.id,
                               :nickname => params[:profil][:nickname],
                               :email => params[:profil][:email],
                               :context => params[:profil][:context],
                               :public => params[:profil][:public].nil? ? false : true
                               )                           
      redirect_to :action => :list
      return
    end
  end


  def delete
    if params[:id]
      begin
        profil = Profil.find(params[:id])
      rescue
        flash[:warning] = I18n.t(:profil_not_found)
        redirect_to :action => :list
      end
      profil.destroy
      redirect_to :action => :list
      return    
    end
  end


end
