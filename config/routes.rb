RedmineFork::Application.routes.draw do
  # Add your own custom routes here.
  # The priority is based upon order of creation: first created -> highest priority.

  # Here's a sample route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  match '', :to => "welcome#index", :as => "home"

  match 'login', :to => "account#login", :as => "signin"
  match 'logout', :to => "account#logout", :as => "signout"

  match 'roles/workflow/:id/:role_id/:tracker_id', :to => "roles#workflow"
  match 'help/:ctrl/:page', :to => "help#index"

  match 'time_entries/:id/edit', :to => "timelog#edit"
  match 'projects/:project_id/time_entries/new', :to => "timelog#edit"
  match 'projects/:project_id/issues/:issue_id/time_entries/new', :to => "timelog#edit"

  controller :timelog do
    match 'projects/:project_id/time_entries', :action => 'details'

    match '(issues/:issue_id/)time_entries', :action => "details", :via => :get
    match 'projects/:project_id(/issues/:issue_id)/time_entries', :action => "details", :via => :get
    match 'projects/:project_id/time_entries/report', :action => 'report'
    match 'time_entries/report', :action => "report", :via => :get
    match 'projects/:project_id/time_entries/report.:format', :action => "report", :via => :get
    match 'issues/:issue_id/time_entries/new', :action => "edit", :via => :get
    match 'time_entries/:id/destroy', :action => 'destroy', :via => :post
  end

  match 'projects/:id/wiki' => "wikis#edit", :via => :post
  match 'projects/:id/wiki/destroy' => "wikis#destroy", :via => [:get, :post]
  controller :wiki, :via => :get do
    match 'projects/:id/wiki/:page', :action => 'special', :page => /page_index|date_index|export/i
    match 'projects/:id/wiki/:page', :action => 'index', :page => nil
    match 'projects/:id/wiki/:page/edit', :action => 'edit'
    match 'projects/:id/wiki/:page/rename', :action => 'rename'
    match 'projects/:id/wiki/:page/history', :action => 'history'
    match 'projects/:id/wiki/:page/diff/:version/vs/:version_from', :action => 'diff'
    match 'projects/:id/wiki/:page/annotate/:version', :action => 'annotate'

    match 'projects/:id/wiki/:page/:action', :action => /edit|rename|destroy|preview|protect/, :via => :post
  end

  controller :messages, :via => :get do
    match 'boards/:board_id/topics/new', :action => 'new'
    match 'boards/:board_id/topics/:id', :action => 'show'
    match 'boards/:board_id/topics/:id/edit', :action => 'edit'
  end
  controller :messages, :via => :post do
    match 'boards/:board_id/topics/new', :action => 'new'
    match 'boards/:board_id/topics/:id/replies', :action => 'reply'
    match 'boards/:board_id/topics/:id/:action', :constraints => {:action => /edit|destroy/}
  end

  controller :boards, :via => :get do
    match 'projects/:project_id/boards', :action => 'index'
    match 'projects/:project_id/boards/new', :action => 'new'
    match 'projects/:project_id/boards/:id', :action => 'show'
    match 'projects/:project_id/boards/:id/edit', :action => 'edit'
  end
  controller :boards, :via => :post do
    match 'projects/:project_id/boards', :action => 'new'
    match 'projects/:project_id/boards/:id/:action', :action => /edit|destroy/
  end

  controller :documents, :via => :get do
      match 'projects/:project_id/documents', :action => 'index'
      match 'projects/:project_id/documents/new', :action => 'new'
      match 'documents/:id', :action => 'show'
      match 'documents/:id/edit', :action => 'edit'
  end
  controller :documents, :via => :post do
      match 'projects/:project_id/documents', :action => 'new'
      match 'documents/:id/:action', :action => /destroy|edit/
  end

  resources :issue_moves, :only => [:new, :create], :path_prefix => '/issues', :as => 'move'

  # Misc issue routes. TODO: move into resources
  match '/issues/auto_complete' => "auto_completes#issues", :as => :auto_complete_issues
  match '/issues/preview/:project_id' => 'previews#issue', :as => :preview_issue # TODO: would look nicer as /issues/:id/preview
  match '/issues/context_menu' => 'context_menus#issues', :as => :issues_context_menu
  match '/issues/changes' => 'journals#index', :as => :issue_changes
  match 'issues/bulk_edit' => 'issues#bulk_edit', :via => :get, :as => :bulk_edit_issue
  match 'issues/bulk_edit' => 'issues#bulk_update', :via => :post, :as => :bulk_update_issue
  match '/issues/:id/quoted' => 'journals#new', :constrainsts => {:id => /\d+/}, :via => :post, :as => :quoted_issue
  match '/issues/:id/destroy' => 'issues#destroy', :via => :post

  resource :gantt, :path_prefix => '/issues', :controller => 'gantts', :only => [:show, :update]
  resource :gantt, :path_prefix => '/projects/:project_id/issues', :controller => 'gantts', :only => [:show, :update]
  resource :calendar, :path_prefix => '/issues', :controller => 'calendars', :only => [:show, :update]
  resource :calendar, :path_prefix => '/projects/:project_id/issues', :controller => 'calendars', :only => [:show, :update]

  controller :reports, :via => :get do
    match 'projects/:id/issues/report', :action => 'issue_report'
    match 'projects/:id/issues/report/:detail', :action => 'issue_report_details'
  end

  # Following two routes conflict with the resources because #index allows POST
  match '/issues' => 'issues#index', :via => :post
  match '/issues/create' => 'issues#index', :via => :post

  resources :issues do
    member do
      post 'edit'
    end
  end

  scope "/projects/:project_id" do
    resources :issues do
      post "create", :on => :collection
    end
  end

  controller :issue_relations, :via => :post do
    match 'issues/:issue_id/relations/:id', :action => 'new'
    match 'issues/:issue_id/relations/:id/destroy', :action => 'destroy'
  end

  controller :news, :via => :get do
    match 'news', :action => 'index'
    match 'projects/:project_id/news', :action => 'index'
    match 'projects/:project_id/news.:format', :action => 'index'
    match 'news.:format', :action => 'index'
    match 'projects/:project_id/news/new', :action => 'new'
    match 'news/:id', :action => 'show'
    match 'news/:id/edit', :action => 'edit'
  end
  controller :news do
    match 'projects/:project_id/news', :action => 'new'
    match 'news/:id/edit', :action => 'edit'
    match 'news/:id/destroy', :action => 'destroy'
  end

  match 'projects/:id/members/new', :to => "members#new"

  controller :users, :via => :get do
      match 'users', :action => 'index'
      match 'users/:id', :action => 'show', :id => /\d+/
      match 'users/new', :action => 'add'
      match 'users/:id/edit/:tab', :action => 'edit', :tab => nil
  end
  controller :users, :via => :post do
    match 'users', :action => 'add'
    match 'users/new', :action => 'add'
    match 'users/:id/edit', :action => 'edit'
    match 'users/:id/memberships', :action => 'edit_membership'
    match 'users/:id/memberships/:membership_id', :action => 'edit_membership'
    match 'users/:id/memberships/:membership_id/destroy', :action => 'destroy_membership'
  end

=begin
  map.with_options :controller => 'projects' do |projects|
    projects.with_options :conditions => {:method => :get} do |project_views|
      project_views.connect 'projects', :action => 'index'
      project_views.connect 'projects.:format', :action => 'index'
      project_views.connect 'projects/new', :action => 'add'
      project_views.connect 'projects/:id', :action => 'show'
      project_views.connect 'projects/:id.:format', :action => 'show'
      project_views.connect 'projects/:id/:action', :action => /destroy|settings/
      project_views.connect 'projects/:id/files', :controller => 'files', :action => 'index'
      project_views.connect 'projects/:id/files/new', :action => 'add_file'
      project_views.connect 'projects/:id/settings/:tab', :action => 'settings'
      project_views.connect 'projects/:project_id/issues/:copy_from/copy', :controller => 'issues', :action => 'new'
    end

    projects.with_options :controller => 'activities', :action => 'index', :conditions => {:method => :get} do |activity|
      activity.connect 'projects/:id/activity'
      activity.connect 'projects/:id/activity.:format'
      activity.connect 'activity', :id => nil
      activity.connect 'activity.:format', :id => nil
    end

    projects.with_options :conditions => {:method => :post} do |project_actions|
      project_actions.connect 'projects/new', :action => 'add'
      project_actions.connect 'projects', :action => 'add'
      project_actions.connect 'projects.:format', :action => 'add', :format => /xml/
      project_actions.connect 'projects/:id/:action', :action => /edit|destroy|archive|unarchive/
      project_actions.connect 'projects/:id/files/new', :action => 'add_file'
      project_actions.connect 'projects/:id/activities/save', :action => 'save_activities'
    end

    projects.with_options :conditions => {:method => :put} do |project_actions|
      project_actions.conditions 'projects/:id.:format', :action => 'edit', :format => /xml/
    end

    projects.with_options :conditions => {:method => :delete} do |project_actions|
      project_actions.conditions 'projects/:id.:format', :action => 'destroy', :format => /xml/
      project_actions.conditions 'projects/:id/reset_activities', :action => 'reset_activities'
    end
  end
=end

  controller :projects, :via => :get do
    match 'projects', :action => 'index'
    match 'projects/new', :action => 'add'
    match 'projects/:id', :action => 'show'
    match 'projects/:id/:action', :action => /destroy|settings/
    match 'projects/:id/files/new', :action => 'add_file'
    match 'projects/:id/settings/:tab', :action => 'settings'
  end

  match 'projects/:id/files' => 'files#index', :via => :get
  match 'projects/:project_id/issues/:copy_from/copy' => 'issues#new', :via => :get

  controller :activities, :action => 'index', :via => :get do
    match 'projects/:id/activity'
    match 'activity', :id => nil
  end

  controller :projects, :via => :post do
    match 'projects/new', :action => 'add'
    match 'projects', :action => 'add'
    match 'projects.:format', :action => 'add', :constraints => { :format => /xml/ }
    match 'projects/:id/:action', :action => /edit|destroy|archive|unarchive/
    match 'projects/:id/files/new', :action => 'add_file'
    match 'projects/:id/activities/save', :action => 'save_activities'
  end

  match 'projects/:id.:format' => 'projects#edit', :via => :put, :constraints => { :format => /xml/ }

  controller :projects, :via => :delete do
    match 'projects/:id.:format', :action => 'destroy', :constraints => { :format => /xml/ }
    match 'projects/:id/reset_activities', :action => 'reset_activities'
  end

  controller :versions do
    match 'projects/:project_id/versions/new', :action => 'new'
    match 'projects/:project_id/roadmap', :action => 'index'
    match 'projects/:project_id/versions/close_completed', :action => 'close_completed', :via => :post
  end

  match "projects/:project_id/issue_categories/new" => "issue_categories#new"

  controller :repositories, :via => :get do
    match 'projects/:id/repository', :action => 'show'
    match 'projects/:id/repository/edit', :action => 'edit'
    match 'projects/:id/repository/statistics', :action => 'stats'
    match 'projects/:id/repository/revisions', :action => 'revisions'
    #match 'projects/:id/repository/revisions.:format', :action => 'revisions'
    match 'projects/:id/repository/revisions/:rev', :action => 'revision'
    match 'projects/:id/repository/revisions/:rev/diff', :action => 'diff'
    #match 'projects/:id/repository/revisions/:rev/diff.:format', :action => 'diff'
    match 'projects/:id/repository/revisions/:rev/raw/*path', :action => 'entry', :format => 'raw', :constraints => { :rev => /[a-z0-9\.\-_]+/ }
    match 'projects/:id/repository/revisions/:rev/:action/*path', :constraints => { :rev => /[a-z0-9\.\-_]+/ }
    match 'projects/:id/repository/raw/*path', :action => 'entry', :format => 'raw'
    # TODO: why the following route is required?
    match 'projects/:id/repository/entry/*path', :action => 'entry'
    match 'projects/:id/repository/:action/*path'
  end
  match 'projects/:id/repository/:action', :controller => "repositories", :via => :post

  match "/attachments/:id", :to => "attachments#show", :constraints => {:id => /\d+/ }
  match 'attachments/:id/:filename', :to => "attachments#show", :constraints => {:id => /\d+/, :filename => /.*/}
  match 'attachments/download/:id/:filename', :to => "attachments#download", :constraints => {:id => /\d+/, :filename => /.*/}

  resources :groups

  #left old routes at the bottom for backwards compat
  #map.connect 'projects/:project_id/issues/:action', :controller => 'issues'
  match 'projects/:project_id/issues/:action', :controller => :issues
  match 'projects/:project_id/documents/:action', :controller => :documents
  match 'projects/:project_id/boards/:action/:id', :controller => :boards
  match 'boards/:board_id/topics/:action/:id', :controller => :message
  match 'wiki/:id(/:page)/:action', :controller => 'wiki'
  match 'issues/:issue_id/relations/:action/:id', :controller => :issue_relations
  match 'projects/:project_id/news/:action', :controller => :news
  match 'projects/:project_id/timelog/:action/:id', :controller => :timelog, :constrainsts => {:project_id => /.+/}
  controller :repositories do
    match 'repositories/browse/:id/*path', :action => 'browse', :as => "repositories_show"
    match 'repositories/changes/:id/*path', :action => 'changes', :as => "repositories_changes"
    match 'repositories/diff/:id/*path', :action => 'diff', :as => "repositories_diff"
    match 'repositories/entry/:id/*path', :action => 'entry', :as => "repositories_entry"
    match 'repositories/annotate/:id/*path', :action => 'annotate'
    match 'repositories/revision/:id/:rev', :action => 'revision'
  end

  controller :sys do
    match 'sys/projects.:format', :action => 'projects', :via => :get
    match 'sys/projects/:id/repository.:format', :action => 'create_project_repository', :via => :post
  end

  # Install the default route as the lowest priority.
  match ':controller(/:action(/:id))'
  match 'robots.txt', :to => "welcome#robots"
  # Used for OpenID
  root :to => "account#login"
end

