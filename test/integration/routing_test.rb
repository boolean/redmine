# redMine - project management software
# Copyright (C) 2006-2010  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.expand_path('../../test_helper', __FILE__)

class RoutingTest < ActionDispatch::IntegrationTest
  context "activities" do
    should route(:get, "/activity").to(:controller => 'activities', :action => 'index', :id => nil)
    should route(:get, "/activity.atom").to(:controller => 'activities', :action => 'index', :id => nil, :format => 'atom')
  end

=begin
  context "attachments" do
    should route :get, "/attachments/1", :controller => 'attachments', :action => 'show', :id => '1'
    should route :get, "/attachments/1/filename.ext", :controller => 'attachments', :action => 'show', :id => '1', :filename => 'filename.ext'
    should route :get, "/attachments/download/1", :controller => 'attachments', :action => 'download', :id => '1'
    should route :get, "/attachments/download/1/filename.ext", :controller => 'attachments', :action => 'download', :id => '1', :filename => 'filename.ext'
  end
  
  context "boards" do
    should route :get, "/projects/world_domination/boards", :controller => 'boards', :action => 'index', :project_id => 'world_domination'
    should route :get, "/projects/world_domination/boards/new", :controller => 'boards', :action => 'new', :project_id => 'world_domination'
    should route :get, "/projects/world_domination/boards/44", :controller => 'boards', :action => 'show', :project_id => 'world_domination', :id => '44'
    should route :get, "/projects/world_domination/boards/44.atom", :controller => 'boards', :action => 'show', :project_id => 'world_domination', :id => '44', :format => 'atom'
    should route :get, "/projects/world_domination/boards/44/edit", :controller => 'boards', :action => 'edit', :project_id => 'world_domination', :id => '44'
           
    should route :post, "/projects/world_domination/boards/new", :controller => 'boards', :action => 'new', :project_id => 'world_domination'
    should route :post, "/projects/world_domination/boards/44/edit", :controller => 'boards', :action => 'edit', :project_id => 'world_domination', :id => '44'
    should route :post, "/projects/world_domination/boards/44/destroy", :controller => 'boards', :action => 'destroy', :project_id => 'world_domination', :id => '44'
    
  end

  context "documents" do
    should route :get, "/projects/567/documents", :controller => 'documents', :action => 'index', :project_id => '567'
    should route :get, "/projects/567/documents/new", :controller => 'documents', :action => 'new', :project_id => '567'
    should route :get, "/documents/22", :controller => 'documents', :action => 'show', :id => '22'
    should route :get, "/documents/22/edit", :controller => 'documents', :action => 'edit', :id => '22'

    should route :post, "/projects/567/documents/new", :controller => 'documents', :action => 'new', :project_id => '567'
    should route :post, "/documents/567/edit", :controller => 'documents', :action => 'edit', :id => '567'
    should route :post, "/documents/567/destroy", :controller => 'documents', :action => 'destroy', :id => '567'
  end
  
  context "issues" do
    # REST actions
    should route :get, "/issues", :controller => 'issues', :action => 'index'
    should route :get, "/issues.pdf", :controller => 'issues', :action => 'index', :format => 'pdf'
    should route :get, "/issues.atom", :controller => 'issues', :action => 'index', :format => 'atom'
    should route :get, "/issues.xml", :controller => 'issues', :action => 'index', :format => 'xml'
    should route :get, "/projects/23/issues", :controller => 'issues', :action => 'index', :project_id => '23'
    should route :get, "/projects/23/issues.pdf", :controller => 'issues', :action => 'index', :project_id => '23', :format => 'pdf'
    should route :get, "/projects/23/issues.atom", :controller => 'issues', :action => 'index', :project_id => '23', :format => 'atom'
    should route :get, "/projects/23/issues.xml", :controller => 'issues', :action => 'index', :project_id => '23', :format => 'xml'
    should route :get, "/issues/64", :controller => 'issues', :action => 'show', :id => '64'
    should route :get, "/issues/64.pdf", :controller => 'issues', :action => 'show', :id => '64', :format => 'pdf'
    should route :get, "/issues/64.atom", :controller => 'issues', :action => 'show', :id => '64', :format => 'atom'
    should route :get, "/issues/64.xml", :controller => 'issues', :action => 'show', :id => '64', :format => 'xml'

    should route :get, "/projects/23/issues/new", :controller => 'issues', :action => 'new', :project_id => '23'
    should route :post, "/projects/23/issues", :controller => 'issues', :action => 'create', :project_id => '23'
    should route :post, "/issues.xml", :controller => 'issues', :action => 'create', :format => 'xml'

    should route :get, "/issues/64/edit", :controller => 'issues', :action => 'edit', :id => '64'
    # TODO: Should use PUT
    should route :post, "/issues/64/edit", :controller => 'issues', :action => 'edit', :id => '64'
    should route :put, "/issues/1.xml", :controller => 'issues', :action => 'update', :id => '1', :format => 'xml'

    # TODO: Should use DELETE
    should route :post, "/issues/64/destroy", :controller => 'issues', :action => 'destroy', :id => '64'
    should route :delete, "/issues/1.xml", :controller => 'issues', :action => 'destroy', :id => '1', :format => 'xml'
    
    # Extra actions
    should route :get, "/projects/23/issues/64/copy", :controller => 'issues', :action => 'new', :project_id => '23', :copy_from => '64'

    should route :get, "/issues/move/new", :controller => 'issue_moves', :action => 'new'
    should route :post, "/issues/move", :controller => 'issue_moves', :action => 'create'
    
    should route :post, "/issues/1/quoted", :controller => 'journals', :action => 'new', :id => '1'

    should route :get, "/issues/calendar", :controller => 'calendars', :action => 'show'
    should route :put, "/issues/calendar", :controller => 'calendars', :action => 'update'
    should route :get, "/projects/project-name/issues/calendar", :controller => 'calendars', :action => 'show', :project_id => 'project-name'
    should route :put, "/projects/project-name/issues/calendar", :controller => 'calendars', :action => 'update', :project_id => 'project-name'

    should route :get, "/issues/gantt", :controller => 'gantts', :action => 'show'
    should route :put, "/issues/gantt", :controller => 'gantts', :action => 'update'
    should route :get, "/projects/project-name/issues/gantt", :controller => 'gantts', :action => 'show', :project_id => 'project-name'
    should route :put, "/projects/project-name/issues/gantt", :controller => 'gantts', :action => 'update', :project_id => 'project-name'

    should route :get, "/issues/auto_complete", :controller => 'auto_completes', :action => 'issues'

    should route :get, "/issues/preview/123", :controller => 'previews', :action => 'issue', :id => '123'
    should route :post, "/issues/preview/123", :controller => 'previews', :action => 'issue', :id => '123'
    should route :get, "/issues/context_menu", :controller => 'context_menus', :action => 'issues'
    should route :post, "/issues/context_menu", :controller => 'context_menus', :action => 'issues'

    should route :get, "/issues/changes", :controller => 'journals', :action => 'index'

    should route :get, "/issues/bulk_edit", :controller => 'issues', :action => 'bulk_edit'
    should route :post, "/issues/bulk_edit", :controller => 'issues', :action => 'bulk_update'
  end

  context "issue categories" do
    should route :get, "/projects/test/issue_categories/new", :controller => 'issue_categories', :action => 'new', :project_id => 'test'

    should route :post, "/projects/test/issue_categories/new", :controller => 'issue_categories', :action => 'new', :project_id => 'test'
  end

  context "issue relations" do
    should route :post, "/issues/1/relations", :controller => 'issue_relations', :action => 'new', :issue_id => '1'
    should route :post, "/issues/1/relations/23/destroy", :controller => 'issue_relations', :action => 'destroy', :issue_id => '1', :id => '23'
  end
  
  context "issue reports" do
    should route :get, "/projects/567/issues/report", :controller => 'reports', :action => 'issue_report', :id => '567'
    should route :get, "/projects/567/issues/report/assigned_to", :controller => 'reports', :action => 'issue_report_details', :id => '567', :detail => 'assigned_to'
  end

  context "members" do
    should route :post, "/projects/5234/members/new", :controller => 'members', :action => 'new', :id => '5234'
  end

  context "messages" do
    should route :get, "/boards/22/topics/2", :controller => 'messages', :action => 'show', :id => '2', :board_id => '22'
    should route :get, "/boards/lala/topics/new", :controller => 'messages', :action => 'new', :board_id => 'lala'
    should route :get, "/boards/lala/topics/22/edit", :controller => 'messages', :action => 'edit', :id => '22', :board_id => 'lala'

    should route :post, "/boards/lala/topics/new", :controller => 'messages', :action => 'new', :board_id => 'lala'
    should route :post, "/boards/lala/topics/22/edit", :controller => 'messages', :action => 'edit', :id => '22', :board_id => 'lala'
    should route :post, "/boards/22/topics/555/replies", :controller => 'messages', :action => 'reply', :id => '555', :board_id => '22'
    should route :post, "/boards/22/topics/555/destroy", :controller => 'messages', :action => 'destroy', :id => '555', :board_id => '22'
  end

  context "news" do
    should route :get, "/news", :controller => 'news', :action => 'index'
    should route :get, "/news.atom", :controller => 'news', :action => 'index', :format => 'atom'
    should route :get, "/news.xml", :controller => 'news', :action => 'index', :format => 'xml'
    should route :get, "/news.json", :controller => 'news', :action => 'index', :format => 'json'
    should route :get, "/projects/567/news", :controller => 'news', :action => 'index', :project_id => '567'
    should route :get, "/projects/567/news.atom", :controller => 'news', :action => 'index', :format => 'atom', :project_id => '567'
    should route :get, "/projects/567/news.xml", :controller => 'news', :action => 'index', :format => 'xml', :project_id => '567'
    should route :get, "/projects/567/news.json", :controller => 'news', :action => 'index', :format => 'json', :project_id => '567'
    should route :get, "/news/2", :controller => 'news', :action => 'show', :id => '2'
    should route :get, "/projects/567/news/new", :controller => 'news', :action => 'new', :project_id => '567'
    should route :get, "/news/234", :controller => 'news', :action => 'show', :id => '234'

    should route :post, "/projects/567/news/new", :controller => 'news', :action => 'new', :project_id => '567'
    should route :post, "/news/567/edit", :controller => 'news', :action => 'edit', :id => '567'
    should route :post, "/news/567/destroy", :controller => 'news', :action => 'destroy', :id => '567'
  end

  context "projects" do
    should route :get, "/projects", :controller => 'projects', :action => 'index'
    should route :get, "/projects.atom", :controller => 'projects', :action => 'index', :format => 'atom'
    should route :get, "/projects.xml", :controller => 'projects', :action => 'index', :format => 'xml'
    should route :get, "/projects/new", :controller => 'projects', :action => 'add'
    should route :get, "/projects/test", :controller => 'projects', :action => 'show', :id => 'test'
    should route :get, "/projects/1.xml", :controller => 'projects', :action => 'show', :id => '1', :format => 'xml'
    should route :get, "/projects/4223/settings", :controller => 'projects', :action => 'settings', :id => '4223'
    should route :get, "/projects/4223/settings/members", :controller => 'projects', :action => 'settings', :id => '4223', :tab => 'members'
    should route :get, "/projects/567/destroy", :controller => 'projects', :action => 'destroy', :id => '567'
    should route :get, "/projects/33/files", :controller => 'files', :action => 'index', :id => '33'
    should route :get, "/projects/33/files/new", :controller => 'projects', :action => 'add_file', :id => '33'
    should route :get, "/projects/33/roadmap", :controller => 'versions', :action => 'index', :project_id => '33'
    should route :get, "/projects/33/activity", :controller => 'activities', :action => 'index', :id => '33'
    should route :get, "/projects/33/activity.atom", :controller => 'activities', :action => 'index', :id => '33', :format => 'atom'
    
    should route :post, "/projects/new", :controller => 'projects', :action => 'add'
    should route :post, "/projects.xml", :controller => 'projects', :action => 'add', :format => 'xml'
    should route :post, "/projects/4223/edit", :controller => 'projects', :action => 'edit', :id => '4223'
    should route :post, "/projects/64/destroy", :controller => 'projects', :action => 'destroy', :id => '64'
    should route :post, "/projects/33/files/new", :controller => 'projects', :action => 'add_file', :id => '33'
    should route :post, "/projects/64/archive", :controller => 'projects', :action => 'archive', :id => '64'
    should route :post, "/projects/64/unarchive", :controller => 'projects', :action => 'unarchive', :id => '64'
    should route :post, "/projects/64/activities/save", :controller => 'projects', :action => 'save_activities', :id => '64'

    should route :put, "/projects/1.xml", :controller => 'projects', :action => 'edit', :id => '1', :format => 'xml'

    should route :delete, "/projects/1.xml", :controller => 'projects', :action => 'destroy', :id => '1', :format => 'xml'
    should route :delete, "/projects/64/reset_activities", :controller => 'projects', :action => 'reset_activities', :id => '64'
  end

  context "repositories" do
    should route :get, "/projects/redmine/repository", :controller => 'repositories', :action => 'show', :id => 'redmine'
    should route :get, "/projects/redmine/repository/edit", :controller => 'repositories', :action => 'edit', :id => 'redmine'
    should route :get, "/projects/redmine/repository/revisions", :controller => 'repositories', :action => 'revisions', :id => 'redmine'
    should route :get, "/projects/redmine/repository/revisions.atom", :controller => 'repositories', :action => 'revisions', :id => 'redmine', :format => 'atom'
    should route :get, "/projects/redmine/repository/revisions/2457", :controller => 'repositories', :action => 'revision', :id => 'redmine', :rev => '2457'
    should route :get, "/projects/redmine/repository/revisions/2457/diff", :controller => 'repositories', :action => 'diff', :id => 'redmine', :rev => '2457'
    should route :get, "/projects/redmine/repository/revisions/2457/diff.diff", :controller => 'repositories', :action => 'diff', :id => 'redmine', :rev => '2457', :format => 'diff'
    should route :get, "/projects/redmine/repository/diff/path/to/file.c", :controller => 'repositories', :action => 'diff', :id => 'redmine', :path => %w[path to file.c]
    should route :get, "/projects/redmine/repository/revisions/2/diff/path/to/file.c", :controller => 'repositories', :action => 'diff', :id => 'redmine', :path => %w[path to file.c], :rev => '2'
    should route :get, "/projects/redmine/repository/browse/path/to/file.c", :controller => 'repositories', :action => 'browse', :id => 'redmine', :path => %w[path to file.c]
    should route :get, "/projects/redmine/repository/entry/path/to/file.c", :controller => 'repositories', :action => 'entry', :id => 'redmine', :path => %w[path to file.c]
    should route :get, "/projects/redmine/repository/revisions/2/entry/path/to/file.c", :controller => 'repositories', :action => 'entry', :id => 'redmine', :path => %w[path to file.c], :rev => '2'
    should route :get, "/projects/redmine/repository/raw/path/to/file.c", :controller => 'repositories', :action => 'entry', :id => 'redmine', :path => %w[path to file.c], :format => 'raw'
    should route :get, "/projects/redmine/repository/revisions/2/raw/path/to/file.c", :controller => 'repositories', :action => 'entry', :id => 'redmine', :path => %w[path to file.c], :rev => '2', :format => 'raw'
    should route :get, "/projects/redmine/repository/annotate/path/to/file.c", :controller => 'repositories', :action => 'annotate', :id => 'redmine', :path => %w[path to file.c]
    should route :get, "/projects/redmine/repository/changes/path/to/file.c", :controller => 'repositories', :action => 'changes', :id => 'redmine', :path => %w[path to file.c]
    should route :get, "/projects/redmine/repository/statistics", :controller => 'repositories', :action => 'stats', :id => 'redmine'
  
    
    should route :post, "/projects/redmine/repository/edit", :controller => 'repositories', :action => 'edit', :id => 'redmine'
  end

  context "timelogs" do
    should route :get, "/issues/567/time_entries/new", :controller => 'timelog', :action => 'edit', :issue_id => '567'
    should route :get, "/projects/ecookbook/time_entries/new", :controller => 'timelog', :action => 'edit', :project_id => 'ecookbook'
    should route :get, "/projects/ecookbook/issues/567/time_entries/new", :controller => 'timelog', :action => 'edit', :project_id => 'ecookbook', :issue_id => '567'
    should route :get, "/time_entries/22/edit", :controller => 'timelog', :action => 'edit', :id => '22'
    should route :get, "/time_entries/report", :controller => 'timelog', :action => 'report'
    should route :get, "/projects/567/time_entries/report", :controller => 'timelog', :action => 'report', :project_id => '567'
    should route :get, "/projects/567/time_entries/report.csv", :controller => 'timelog', :action => 'report', :project_id => '567', :format => 'csv'
    should route :get, "/time_entries", :controller => 'timelog', :action => 'details'
    should route :get, "/time_entries.csv", :controller => 'timelog', :action => 'details', :format => 'csv'
    should route :get, "/time_entries.atom", :controller => 'timelog', :action => 'details', :format => 'atom'
    should route :get, "/projects/567/time_entries", :controller => 'timelog', :action => 'details', :project_id => '567'
    should route :get, "/projects/567/time_entries.csv", :controller => 'timelog', :action => 'details', :project_id => '567', :format => 'csv'
    should route :get, "/projects/567/time_entries.atom", :controller => 'timelog', :action => 'details', :project_id => '567', :format => 'atom'
    should route :get, "/issues/234/time_entries", :controller => 'timelog', :action => 'details', :issue_id => '234'
    should route :get, "/issues/234/time_entries.csv", :controller => 'timelog', :action => 'details', :issue_id => '234', :format => 'csv'
    should route :get, "/issues/234/time_entries.atom", :controller => 'timelog', :action => 'details', :issue_id => '234', :format => 'atom'
    should route :get, "/projects/ecookbook/issues/123/time_entries", :controller => 'timelog', :action => 'details', :project_id => 'ecookbook', :issue_id => '123'
           
    should route :post, "/time_entries/55/destroy", :controller => 'timelog', :action => 'destroy', :id => '55'
  end

  context "users" do
    should route :get, "/users", :controller => 'users', :action => 'index'
    should route :get, "/users/44", :controller => 'users', :action => 'show', :id => '44'
    should route :get, "/users/new", :controller => 'users', :action => 'add'
    should route :get, "/users/444/edit", :controller => 'users', :action => 'edit', :id => '444'
    should route :get, "/users/222/edit/membership", :controller => 'users', :action => 'edit', :id => '222', :tab => 'membership'
           
    should route :post, "/users/new", :controller => 'users', :action => 'add'
    should route :post, "/users/444/edit", :controller => 'users', :action => 'edit', :id => '444'
    should route :post, "/users/123/memberships", :controller => 'users', :action => 'edit_membership', :id => '123'
    should route :post, "/users/123/memberships/55", :controller => 'users', :action => 'edit_membership', :id => '123', :membership_id => '55'
    should route :post, "/users/567/memberships/12/destroy", :controller => 'users', :action => 'destroy_membership', :id => '567', :membership_id => '12'
  end

  context "versions" do
    should route :get, "/projects/foo/versions/new", :controller => 'versions', :action => 'new', :project_id => 'foo'

    should route :post, "/projects/foo/versions/new", :controller => 'versions', :action => 'new', :project_id => 'foo'
  end

  context "wiki (singular, project's pages)" do
    should route :get, "/projects/567/wiki", :controller => 'wiki', :action => 'index', :id => '567'
    should route :get, "/projects/567/wiki/lalala", :controller => 'wiki', :action => 'index', :id => '567', :page => 'lalala'
    should route :get, "/projects/567/wiki/my_page/edit", :controller => 'wiki', :action => 'edit', :id => '567', :page => 'my_page'
    should route :get, "/projects/1/wiki/CookBook_documentation/history", :controller => 'wiki', :action => 'history', :id => '1', :page => 'CookBook_documentation'
    should route :get, "/projects/1/wiki/CookBook_documentation/diff/2/vs/1", :controller => 'wiki', :action => 'diff', :id => '1', :page => 'CookBook_documentation', :version => '2', :version_from => '1'
    should route :get, "/projects/1/wiki/CookBook_documentation/annotate/2", :controller => 'wiki', :action => 'annotate', :id => '1', :page => 'CookBook_documentation', :version => '2'
    should route :get, "/projects/22/wiki/ladida/rename", :controller => 'wiki', :action => 'rename', :id => '22', :page => 'ladida'
    should route :get, "/projects/567/wiki/page_index", :controller => 'wiki', :action => 'special', :id => '567', :page => 'page_index'
    should route :get, "/projects/567/wiki/Page_Index", :controller => 'wiki', :action => 'special', :id => '567', :page => 'Page_Index'
    should route :get, "/projects/567/wiki/date_index", :controller => 'wiki', :action => 'special', :id => '567', :page => 'date_index'
    should route :get, "/projects/567/wiki/export", :controller => 'wiki', :action => 'special', :id => '567', :page => 'export'

    should route :post, "/projects/567/wiki/my_page/edit", :controller => 'wiki', :action => 'edit', :id => '567', :page => 'my_page'
    should route :post, "/projects/567/wiki/CookBook_documentation/preview", :controller => 'wiki', :action => 'preview', :id => '567', :page => 'CookBook_documentation'
    should route :post, "/projects/22/wiki/ladida/rename", :controller => 'wiki', :action => 'rename', :id => '22', :page => 'ladida'
    should route :post, "/projects/22/wiki/ladida/destroy", :controller => 'wiki', :action => 'destroy', :id => '22', :page => 'ladida'
    should route :post, "/projects/22/wiki/ladida/protect", :controller => 'wiki', :action => 'protect', :id => '22', :page => 'ladida'
  end

  context "wikis (plural, admin setup)" do
    should route :get, "/projects/ladida/wiki/destroy", :controller => 'wikis', :action => 'destroy', :id => 'ladida'

    should route :post, "/projects/ladida/wiki", :controller => 'wikis', :action => 'edit', :id => 'ladida'
    should route :post, "/projects/ladida/wiki/destroy", :controller => 'wikis', :action => 'destroy', :id => 'ladida'
  end

  context "administration panel" do
    should route :get, "/admin/projects", :controller => 'admin', :action => 'projects'
  end
=end
end
