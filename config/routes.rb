Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :banner_boxes do
      collection do
        get :edit_box_by_category
        post :update_positions
      end
      member do
        get :clone
      end
    end
    resource :banner_box_settings
  end
end
