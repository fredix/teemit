require 'avatar/view/action_view_support'

module UsersHelper
  include Avatar::View::ActionViewSupport
  #include Avatar::View::AbstractViewSupport
  
  def avatar_user(user)
    if user.public
      if !user.gravatar and user.avatar_url
        return link_to(image_tag(user.avatar_url(:thumb)), "/#{user.login}", :title => user.login)
      elsif user.gravatar
        return link_to(avatar_tag(user, :size => 50), "/#{user.login}", :title => user.login)
      else
        return link_to(image_tag("avatars_users/missing.png"), "/#{user.login}", :title => user.login)
      end 
    else
      return image_tag("avatars_users/anonymous.jpg", :title => "anonymous")
    end
  end

end
