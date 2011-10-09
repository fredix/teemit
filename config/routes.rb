Nodecast::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'register', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock' }

  #devise_for :users

  resource :account, :controller => "users"

  resources :host do
    collection do
      get :public
      get :show
      get :delete
      put :delete
      put :block
      put :unblock
    end
  end

  resource :profils do
    member do
      get :list
      get :mine
    end
  end

  resources :users do
    collection do
      get :nickname
      get :public
      get :show
      get :hosts
      get :delete
    end
  end

  resources :main do
    collection do
      get :overview
      get :download
      get :about
      get :privacy
      get :contacts
    end
  end


  resources :report do
    collection do
      get :all
      get :load
      get :memory
      get :network
      get :cpu
      get :processus
      get :uptime
      get :uptimes
      get :os
      get :plateform
      get :country
      get :city
    end
  end


  #resources :users, :only => :show

  match "welcome" => "welcome#index" # same as: map.connect "welcome", :controller => "welcome", :action => "index"


  match 'users' => "users#public"
  match "hosts" => "host#public"

  match "account/settings" => "users#settings"

 
 # map.connect 'hosts', :controller => 'host', :action => 'index'



  match "hosts/public" => "host#public"
  match "hosts/mine" => "host#mine"


  match "host/:id" => "host#show"
#  map.connect 'hosts/search/:id', :controller => 'host', :action => 'search'

  match "user/:id" => "users#show"


  match ":user" => "users#nickname"
  match ":user/hosts" => "users#hosts"


  root :to => "main#index"

end
