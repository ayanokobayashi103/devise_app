Rails.application.routes.draw do
  devise_for :shopadmins, controllers: {
  sessions:      'shopadmins/sessions',
  passwords:     'shopadmins/passwords',
  registrations: 'shopadmins/registrations'
}
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  resources :users, only: [:index] #resources :usersの項に[:index]のルーティングを追加する
  root to: "blogs#index"
  resources :relationships, only: [:create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :blogs do
    resources :comments
  end
end
