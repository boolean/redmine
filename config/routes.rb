RedmineFork::Application.routes.draw do
  match '' => 'welcome#index', :as => :home
  match 'login' => 'account#login', :as => :signin
  match 'logout' => 'account#logout', :as => :signout
  match 'roles/workflow/:id/:role_id/:tracker_id' => 'roles#workflow'
  match 'help/:ctrl/:page' => 'help#index'
  match 'time_entries/:id/edit' => 'timelog#edit'
  match 'projects/:project_id/time_entries/new' => 'timelog#edit'
  match 'projects/:project_id/issues/:issue_id/time_entries/new' => 'timelog#edit'
  match '{:controller=>"timelog"}' => '#index', :as => :with_options
  match 'projects/:id/wiki' => 'wikis#edit', :via => :post
  match 'projects/:id/wiki/destroy' => 'wikis#destroy', :via => :get
  match 'projects/:id/wiki/destroy' => 'wikis#destroy', :via => :post
  match '{:controller=>"wiki"}' => '#index', :as => :with_options
  match '{:controller=>"messages"}' => '#index', :as => :with_options
  match '{:controller=>"boards"}' => '#index', :as => :with_options
  match '{:controller=>"documents"}' => '#index', :as => :with_options
  resources :issue_moves
  match '/issues/auto_complete' => 'auto_completes#issues', :as => :auto_complete_issues
  match '/issues/preview/:id' => 'previews#issue', :as => :preview_issue
  match '/issues/context_menu' => 'context_menus#issues', :as => :issues_context_menu
  match '/issues/changes' => 'journals#index', :as => :issue_changes
  match 'issues/bulk_edit' => 'issues#bulk_edit', :as => :bulk_edit_issue, :via => :get
  match 'issues/bulk_edit' => 'issues#bulk_update', :as => :bulk_update_issue, :via => :post
  match '/issues/:id/quoted' => 'journals#new', :as => :quoted_issue, :id => /\d+/, :via => :post
  match '/issues/:id/destroy' => 'issues#destroy', :via => :post
  resource :gantt
  resource :gantt
  resource :calendar
  resource :calendar
  match '{:controller=>"reports", :conditions=>{:method=>:get}}' => '#index', :as => :with_options
  match '/issues' => 'issues#index', :via => :post
  match '/issues/create' => 'issues#index', :via => :post
  resources :issues do
    collection do
  end
    member do
  post :edit
  end
  
  end

  resources :issues do
    collection do
  post :create
  end
  
  
  end

  match '{:controller=>"issue_relations", :conditions=>{:method=>:post}}' => '#index', :as => :with_options
  match '{:controller=>"news"}' => '#index', :as => :with_options
  match 'projects/:id/members/new' => 'members#new'
  match '{:controller=>"users"}' => '#index', :as => :with_options
  match '{:controller=>"projects"}' => '#index', :as => :with_options
  match '{:controller=>"versions"}' => '#index', :as => :with_options
  match '{:controller=>"issue_categories"}' => '#index', :as => :with_options
  match '{:controller=>"repositories"}' => '#index', :as => :with_options
  match 'attachments/:id' => 'attachments#show', :id => /\d+/
  match 'attachments/:id/:filename' => 'attachments#show', :id => /\d+/, :filename => /.*/
  match 'attachments/download/:id/:filename' => 'attachments#download', :id => /\d+/, :filename => /.*/
  resources :groups
  match 'projects/:project_id/issues/:action' => 'issues#index'
  match 'projects/:project_id/documents/:action' => 'documents#index'
  match 'projects/:project_id/boards/:action/:id' => 'boards#index'
  match 'boards/:board_id/topics/:action/:id' => 'messages#index'
  match 'wiki/:id/:page/:action' => 'wiki#index'
  match 'issues/:issue_id/relations/:action/:id' => 'issue_relations#index'
  match 'projects/:project_id/news/:action' => 'news#index'
  match 'projects/:project_id/timelog/:action/:id' => 'timelog#index', :project_id => /.+/
  match '{:controller=>"repositories"}' => '#index', :as => :with_options
  match '{:controller=>"sys"}' => '#index', :as => :with_options
  match '/:controller(/:action(/:id))'
  match 'robots.txt' => 'welcome#robots'
  match '/' => 'account#login'
end

