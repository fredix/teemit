require 'avatar/view/action_view_support'

module HostHelper
  def avatar_host(host)
    if host.public      
      if !host.blocked
        if host.avatar_url
          return link_to(image_tag(host.avatar_url(:thumb)), {:controller => :host, :action => :show, :id => host.pub_uuid}, :title => h(host.network.hostname))
        else
          return link_to(image_tag("avatars_hosts/missing.png"), {:controller => :host, :action => :show, :id => host.pub_uuid}, :title => h(host.network.hostname))
        end 
      else
          return link_to(image_tag("avatars_hosts/denied.jpeg", :title => I18n.t(:blocked)), {:controller => :host, :action => :show, :id => host.pub_uuid}, :title => h(host.network.hostname))
      end
    else
      return image_tag("avatars_hosts/anonymous.jpg", :title => "anonymous")
    end
  end

end
