Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'musics', to: 'musics#index', as: 'musics_index'

  get 'musics/:idstr/:difficulty', to: 'musics#show', as: 'musics_show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
