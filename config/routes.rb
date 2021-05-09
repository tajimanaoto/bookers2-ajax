Rails.application.routes.draw do
  get 'search' => "search#search"
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    # この記述を「ネストする」という
    # このようにコーディングすることでどのbookに対してのいいねやコメントなのかを紐づける事ができる
    # 複数形と単数形の違いは情報が複数か一つしかないかの違い
    # resourceの違いに関してはhttps://qiita.com/wacker8818/items/1ba526fcbc73e065a511を参照すると良い
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
  resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end

end