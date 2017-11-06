Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'musics/index'

  get 'musics/show/:idstr/:difficulty', to: 'musics#show', as: 'musics_show'

  root 'musics#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
