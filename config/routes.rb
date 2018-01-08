Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/index'

  get 'users/show'

  get 'musics/index'

  get 'musics/show/:idstr/:difficulty', to: 'musics#show', as: 'musics_show'

  root 'musics#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
