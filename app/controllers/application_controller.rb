class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time
  before_filter :set_locale
  before_filter :check_recaptcha_for_devise, :only => :create

  layout 'web', :except => :rss

  helper_method :current_user_session, :current_user

  def set_locale   
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
    #   request.user_preferred_languages
    #available = %w{en fr en_US fr_FR}
    #I18n.locale = request.compatible_language_from(available)
    # request.compatible_language_from(available)
    #    I18n.locale = request.compatible_language_from I18n.available_locales
  end

  #####
  private
  #####


  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def check_recaptcha_for_devise
    # mark Devise Controllers to be excluded from verify_recaptcha
    except_devise_controllers = [:sessions, :passwords]
    
    # check if it's a devise_controller? and if marked for verify_recaptcha
    if devise_controller? && !except_devise_controllers.include?(controller_name.to_sym)
      
      # build the resource first and then check recaptcha challenge
      build_resource
      unless verify_recaptcha()
        
        # if it fails add the error and render the form back to the client
        message = I18n.t(:captcha)
        flash[:error] = message
        #resource.errors.add_to_base(message)
        render_with_scope :new
      end
    end
  end
  
    
  def store_location
    session[:return_to] = request.request_uri
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  
  def generate_uuid
    UUIDTools::UUID.timestamp_create.to_s
  end

end
