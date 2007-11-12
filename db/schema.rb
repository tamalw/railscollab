# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 4) do

  create_table "administration_tools", :force => true do |t|
    t.column "name",       :string,  :limit => 50, :default => "", :null => false
    t.column "controller", :string,  :limit => 50, :default => "", :null => false
    t.column "action",     :string,  :limit => 50, :default => "", :null => false
    t.column "order",      :integer, :limit => 3,  :default => 0,  :null => false
  end

  add_index "administration_tools", ["name"], :name => "name", :unique => true

  create_table "application_logs", :force => true do |t|
    t.column "taken_by_id",     :integer,  :limit => 10
    t.column "project_id",      :integer,  :limit => 10,                                             :default => 0,     :null => false
    t.column "rel_object_id",   :integer,  :limit => 10,                                             :default => 0,     :null => false
    t.column "object_name",     :text
    t.column "rel_object_type", :string,   :limit => 50
    t.column "created_on",      :datetime,                                                                              :null => false
    t.column "created_by_id",   :integer,  :limit => 10
    t.column "action",          :enum,     :limit => [:upload, :open, :close, :delete, :edit, :add]
    t.column "is_private",      :boolean,                                                            :default => false, :null => false
    t.column "is_silent",       :boolean,                                                            :default => false, :null => false
  end

  add_index "application_logs", ["created_on"], :name => "created_on"
  add_index "application_logs", ["project_id"], :name => "project_id"

  create_table "attached_files", :id => false, :force => true do |t|
    t.column "rel_object_type", :string,   :limit => 50
    t.column "rel_object_id",   :integer,  :limit => 10, :default => 0, :null => false
    t.column "file_id",         :integer,  :limit => 10, :default => 0, :null => false
    t.column "created_on",      :datetime,                              :null => false
    t.column "created_by_id",   :integer,  :limit => 10
  end

  create_table "comments", :force => true do |t|
    t.column "rel_object_id",   :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "rel_object_type", :string,   :limit => 30
    t.column "text",            :text
    t.column "is_private",      :boolean,                 :default => false, :null => false
    t.column "is_anonymous",    :boolean,                 :default => false, :null => false
    t.column "author_name",     :string,   :limit => 50
    t.column "author_email",    :string,   :limit => 100
    t.column "author_homepage", :string,   :limit => 100, :default => "",    :null => false
    t.column "created_on",      :datetime,                                   :null => false
    t.column "created_by_id",   :integer,  :limit => 10
    t.column "updated_on",      :datetime
    t.column "updated_by_id",   :integer,  :limit => 10
  end

  add_index "comments", ["rel_object_id", "rel_object_type"], :name => "object_id"
  add_index "comments", ["created_on"], :name => "created_on"

  create_table "companies", :force => true do |t|
    t.column "client_of_id",      :integer,  :limit => 5
    t.column "name",              :string,   :limit => 50
    t.column "email",             :string,   :limit => 100
    t.column "homepage",          :string,   :limit => 100
    t.column "address",           :string,   :limit => 100
    t.column "address2",          :string,   :limit => 100
    t.column "city",              :string,   :limit => 50
    t.column "state",             :string,   :limit => 50
    t.column "zipcode",           :string,   :limit => 30
    t.column "country",           :string,   :limit => 10
    t.column "phone_number",      :string,   :limit => 30
    t.column "fax_number",        :string,   :limit => 30
    t.column "logo_file",         :string,   :limit => 44
    t.column "timezone",          :float,                   :default => 0.0,   :null => false
    t.column "hide_welcome_info", :boolean,                 :default => false, :null => false
    t.column "created_on",        :datetime,                                   :null => false
    t.column "created_by_id",     :integer,  :limit => 10
    t.column "updated_on",        :datetime
    t.column "updated_by_id",     :integer,  :limit => 10
  end

  add_index "companies", ["created_on"], :name => "created_on"
  add_index "companies", ["client_of_id"], :name => "client_of_id"

  create_table "config_categories", :force => true do |t|
    t.column "name",           :string,  :limit => 50, :default => "",    :null => false
    t.column "is_system",      :boolean,               :default => false, :null => false
    t.column "category_order", :integer, :limit => 3,  :default => 0,     :null => false
  end

  add_index "config_categories", ["name"], :name => "name", :unique => true
  add_index "config_categories", ["category_order"], :name => "order"

  create_table "config_options", :force => true do |t|
    t.column "category_name",        :string,  :limit => 30, :default => "",    :null => false
    t.column "name",                 :string,  :limit => 50, :default => "",    :null => false
    t.column "value",                :text
    t.column "config_handler_class", :string,  :limit => 50, :default => "",    :null => false
    t.column "is_system",            :boolean,               :default => false, :null => false
    t.column "option_order",         :integer, :limit => 5,  :default => 0,     :null => false
    t.column "dev_comment",          :string
  end

  add_index "config_options", ["name"], :name => "name", :unique => true
  add_index "config_options", ["option_order"], :name => "order"
  add_index "config_options", ["category_name"], :name => "category_id"

  create_table "file_repo", :force => true do |t|
    t.column "content", :binary,                :default => "", :null => false
    t.column "order",   :integer, :limit => 10, :default => 0,  :null => false
  end

  add_index "file_repo", ["order"], :name => "order"

  create_table "file_repo_attributes", :force => true do |t|
    t.column "attribute", :string, :limit => 50, :default => "", :null => false
    t.column "value",     :text,                 :default => "", :null => false
  end

  create_table "file_types", :force => true do |t|
    t.column "extension",     :string,  :limit => 10, :default => "",    :null => false
    t.column "icon",          :string,  :limit => 30, :default => "",    :null => false
    t.column "is_searchable", :boolean,               :default => false, :null => false
    t.column "is_image",      :boolean,               :default => false, :null => false
  end

  add_index "file_types", ["extension"], :name => "extension", :unique => true

  create_table "im_types", :force => true do |t|
    t.column "name", :string, :limit => 30, :default => "", :null => false
    t.column "icon", :string, :limit => 30, :default => "", :null => false
  end

  create_table "message_subscriptions", :id => false, :force => true do |t|
    t.column "message_id", :integer, :limit => 10, :default => 0, :null => false
    t.column "user_id",    :integer, :limit => 10, :default => 0, :null => false
  end

  create_table "open_id_associations", :force => true do |t|
    t.column "server_url", :binary
    t.column "handle",     :string
    t.column "secret",     :binary
    t.column "issued",     :integer
    t.column "lifetime",   :integer
    t.column "assoc_type", :string
  end

  create_table "open_id_nonces", :force => true do |t|
    t.column "nonce",   :string
    t.column "created", :integer
  end

  create_table "open_id_settings", :force => true do |t|
    t.column "setting", :string
    t.column "value",   :binary
  end

  create_table "project_companies", :id => false, :force => true do |t|
    t.column "project_id", :integer, :limit => 10, :default => 0, :null => false
    t.column "company_id", :integer, :limit => 5,  :default => 0, :null => false
  end

  create_table "project_file_revisions", :force => true do |t|
    t.column "file_id",         :integer,  :limit => 10, :default => 0,  :null => false
    t.column "file_type_id",    :integer,  :limit => 5,  :default => 0,  :null => false
    t.column "repository_id",   :string,   :limit => 40, :default => "", :null => false
    t.column "thumb_filename",  :string,   :limit => 44
    t.column "revision_number", :integer,  :limit => 10, :default => 0,  :null => false
    t.column "comment",         :text
    t.column "type_string",     :string,   :limit => 50, :default => "", :null => false
    t.column "filesize",        :integer,  :limit => 10, :default => 0,  :null => false
    t.column "created_on",      :datetime,                               :null => false
    t.column "created_by_id",   :integer,  :limit => 10
    t.column "updated_on",      :datetime
    t.column "updated_by_id",   :integer,  :limit => 10
  end

  add_index "project_file_revisions", ["file_id"], :name => "file_id"
  add_index "project_file_revisions", ["updated_on"], :name => "updated_on"
  add_index "project_file_revisions", ["revision_number"], :name => "revision_number"

  create_table "project_files", :force => true do |t|
    t.column "project_id",                 :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "folder_id",                  :integer,  :limit => 5,   :default => 0,     :null => false
    t.column "filename",                   :string,   :limit => 100, :default => "",    :null => false
    t.column "description",                :text
    t.column "is_private",                 :boolean,                 :default => false, :null => false
    t.column "is_important",               :boolean,                 :default => false, :null => false
    t.column "is_locked",                  :boolean,                 :default => false, :null => false
    t.column "is_visible",                 :boolean,                 :default => false, :null => false
    t.column "expiration_time",            :datetime
    t.column "comments_enabled",           :boolean,                 :default => false, :null => false
    t.column "anonymous_comments_enabled", :boolean,                 :default => false, :null => false
    t.column "created_on",                 :datetime,                                   :null => false
    t.column "created_by_id",              :integer,  :limit => 10,  :default => 0
    t.column "updated_on",                 :datetime
    t.column "updated_by_id",              :integer,  :limit => 10,  :default => 0
  end

  add_index "project_files", ["project_id"], :name => "project_id"

  create_table "project_folders", :force => true do |t|
    t.column "project_id", :integer, :limit => 10, :default => 0,  :null => false
    t.column "name",       :string,  :limit => 50, :default => "", :null => false
  end

  add_index "project_folders", ["project_id", "name"], :name => "project_id", :unique => true

  create_table "project_forms", :force => true do |t|
    t.column "project_id",      :integer,  :limit => 10,                        :default => 0,            :null => false
    t.column "name",            :string,   :limit => 50,                        :default => "",           :null => false
    t.column "description",     :text,                                          :default => "",           :null => false
    t.column "success_message", :text,                                          :default => "",           :null => false
    t.column "action",          :enum,     :limit => [:add_comment, :add_task], :default => :add_comment, :null => false
    t.column "in_object_id",    :integer,  :limit => 10,                        :default => 0,            :null => false
    t.column "created_on",      :datetime
    t.column "created_by_id",   :integer,  :limit => 10,                        :default => 0,            :null => false
    t.column "updated_on",      :datetime
    t.column "updated_by_id",   :integer,  :limit => 10,                        :default => 0,            :null => false
    t.column "is_visible",      :boolean,                                       :default => false,        :null => false
    t.column "is_enabled",      :boolean,                                       :default => false,        :null => false
    t.column "order",           :integer,  :limit => 6,                         :default => 0,            :null => false
  end

  create_table "project_messages", :force => true do |t|
    t.column "milestone_id",               :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "project_id",                 :integer,  :limit => 10
    t.column "title",                      :string,   :limit => 100
    t.column "text",                       :text
    t.column "additional_text",            :text
    t.column "is_important",               :boolean,                 :default => false, :null => false
    t.column "is_private",                 :boolean,                 :default => false, :null => false
    t.column "comments_enabled",           :boolean,                 :default => false, :null => false
    t.column "anonymous_comments_enabled", :boolean,                 :default => false, :null => false
    t.column "created_on",                 :datetime,                                   :null => false
    t.column "created_by_id",              :integer,  :limit => 10
    t.column "updated_on",                 :datetime
    t.column "updated_by_id",              :integer,  :limit => 10
  end

  add_index "project_messages", ["milestone_id"], :name => "milestone_id"
  add_index "project_messages", ["project_id"], :name => "project_id"
  add_index "project_messages", ["created_on"], :name => "created_on"

  create_table "project_milestones", :force => true do |t|
    t.column "project_id",             :integer,  :limit => 10
    t.column "name",                   :string,   :limit => 100
    t.column "description",            :text
    t.column "due_date",               :datetime
    t.column "assigned_to_company_id", :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "assigned_to_user_id",    :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "is_private",             :boolean,                 :default => false, :null => false
    t.column "completed_on",           :datetime
    t.column "completed_by_id",        :integer,  :limit => 10
    t.column "created_on",             :datetime,                                   :null => false
    t.column "created_by_id",          :integer,  :limit => 10
    t.column "updated_on",             :datetime
    t.column "updated_by_id",          :integer,  :limit => 10
  end

  add_index "project_milestones", ["project_id"], :name => "project_id"
  add_index "project_milestones", ["due_date"], :name => "due_date"
  add_index "project_milestones", ["completed_on"], :name => "completed_on"
  add_index "project_milestones", ["created_on"], :name => "created_on"

  create_table "project_task_lists", :force => true do |t|
    t.column "priority",        :integer
    t.column "milestone_id",    :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "project_id",      :integer,  :limit => 10
    t.column "name",            :string,   :limit => 100
    t.column "description",     :text
    t.column "is_private",      :boolean,                 :default => false, :null => false
    t.column "completed_on",    :datetime
    t.column "completed_by_id", :integer,  :limit => 10
    t.column "created_on",      :datetime
    t.column "created_by_id",   :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "updated_on",      :datetime
    t.column "updated_by_id",   :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "order",           :integer,  :limit => 3,   :default => 0,     :null => false
  end

  add_index "project_task_lists", ["milestone_id"], :name => "milestone_id"
  add_index "project_task_lists", ["project_id"], :name => "project_id"
  add_index "project_task_lists", ["completed_on"], :name => "completed_on"
  add_index "project_task_lists", ["created_on"], :name => "created_on"

  create_table "project_tasks", :force => true do |t|
    t.column "task_list_id",           :integer,  :limit => 10
    t.column "text",                   :text
    t.column "assigned_to_company_id", :integer,  :limit => 5
    t.column "assigned_to_user_id",    :integer,  :limit => 10
    t.column "completed_on",           :datetime
    t.column "completed_by_id",        :integer,  :limit => 10
    t.column "created_on",             :datetime,                              :null => false
    t.column "created_by_id",          :integer,  :limit => 10
    t.column "updated_on",             :datetime
    t.column "updated_by_id",          :integer,  :limit => 10
    t.column "order",                  :integer,  :limit => 10, :default => 0, :null => false
  end

  add_index "project_tasks", ["task_list_id"], :name => "task_list_id"
  add_index "project_tasks", ["completed_on"], :name => "completed_on"
  add_index "project_tasks", ["created_on"], :name => "created_on"
  add_index "project_tasks", ["order"], :name => "order"

  create_table "project_times", :force => true do |t|
    t.column "project_id",             :integer,  :limit => 10
    t.column "task_list_id",           :integer
    t.column "task_id",                :integer
    t.column "name",                   :string,   :limit => 100
    t.column "description",            :text
    t.column "done_date",              :datetime
    t.column "hours",                  :float,                   :default => 0.0,   :null => false
    t.column "is_billable",            :boolean,                 :default => true,  :null => false
    t.column "assigned_to_company_id", :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "assigned_to_user_id",    :integer,  :limit => 10,  :default => 0,     :null => false
    t.column "is_private",             :boolean,                 :default => false, :null => false
    t.column "created_on",             :datetime,                                   :null => false
    t.column "created_by_id",          :integer,  :limit => 10
    t.column "updated_on",             :datetime
    t.column "updated_by_id",          :integer,  :limit => 10
  end

  add_index "project_times", ["project_id"], :name => "project_id"
  add_index "project_times", ["done_date"], :name => "done_date"
  add_index "project_times", ["created_on"], :name => "created_on"

  create_table "project_users", :id => false, :force => true do |t|
    t.column "project_id",            :integer,  :limit => 10, :default => 0,     :null => false
    t.column "user_id",               :integer,  :limit => 10, :default => 0,     :null => false
    t.column "created_on",            :datetime
    t.column "created_by_id",         :integer,  :limit => 10, :default => 0,     :null => false
    t.column "can_manage_messages",   :boolean,                :default => false
    t.column "can_manage_tasks",      :boolean,                :default => false
    t.column "can_manage_milestones", :boolean,                :default => false
    t.column "can_upload_files",      :boolean,                :default => false
    t.column "can_manage_files",      :boolean,                :default => false
    t.column "can_assign_to_owners",  :boolean,                :default => false, :null => false
    t.column "can_assign_to_other",   :boolean,                :default => false, :null => false
    t.column "can_manage_time",       :boolean,                :default => false, :null => false
  end

  create_table "projects", :force => true do |t|
    t.column "priority",                     :integer
    t.column "name",                         :string,   :limit => 50
    t.column "description",                  :text
    t.column "show_description_in_overview", :boolean,                :default => false, :null => false
    t.column "completed_on",                 :datetime
    t.column "completed_by_id",              :integer
    t.column "created_on",                   :datetime,                                  :null => false
    t.column "created_by_id",                :integer,  :limit => 10
    t.column "updated_on",                   :datetime
    t.column "updated_by_id",                :integer,  :limit => 10
  end

  add_index "projects", ["completed_on"], :name => "completed_on"

  create_table "searchable_objects", :id => false, :force => true do |t|
    t.column "rel_object_type", :string,  :limit => 50
    t.column "rel_object_id",   :integer, :limit => 10, :default => 0,     :null => false
    t.column "column_name",     :string,  :limit => 50, :default => "",    :null => false
    t.column "content",         :text,                  :default => "",    :null => false
    t.column "project_id",      :integer, :limit => 10, :default => 0,     :null => false
    t.column "is_private",      :boolean,               :default => false, :null => false
  end

  add_index "searchable_objects", ["project_id"], :name => "project_id"

  create_table "tags", :force => true do |t|
    t.column "project_id",      :integer,  :limit => 10, :default => 0,     :null => false
    t.column "tag",             :string,   :limit => 30, :default => "",    :null => false
    t.column "rel_object_id",   :integer,  :limit => 10, :default => 0,     :null => false
    t.column "rel_object_type", :string,   :limit => 50
    t.column "created_on",      :datetime
    t.column "created_by_id",   :integer,  :limit => 10, :default => 0,     :null => false
    t.column "is_private",      :boolean,                :default => false, :null => false
  end

  add_index "tags", ["project_id"], :name => "project_id"
  add_index "tags", ["tag"], :name => "tag"
  add_index "tags", ["rel_object_id", "rel_object_type"], :name => "object_id"

  create_table "test_rests", :force => true do |t|
    t.column "name",       :string,  :limit => 50, :default => "", :null => false
    t.column "controller", :string,  :limit => 50, :default => "", :null => false
    t.column "action",     :string,  :limit => 50, :default => "", :null => false
    t.column "order",      :integer, :limit => 3,  :default => 0,  :null => false
  end

  create_table "user_im_values", :id => false, :force => true do |t|
    t.column "user_id",    :integer, :limit => 10, :default => 0,     :null => false
    t.column "im_type_id", :integer, :limit => 3,  :default => 0,     :null => false
    t.column "value",      :string,  :limit => 50, :default => "",    :null => false
    t.column "is_default", :boolean,               :default => false, :null => false
  end

  add_index "user_im_values", ["is_default"], :name => "is_default"

  create_table "users", :force => true do |t|
    t.column "company_id",    :integer,  :limit => 5,   :default => 0,     :null => false
    t.column "username",      :string,   :limit => 50,  :default => "",    :null => false
    t.column "email",         :string,   :limit => 100
    t.column "token",         :string,   :limit => 40,  :default => "",    :null => false
    t.column "salt",          :string,   :limit => 13,  :default => "",    :null => false
    t.column "twister",       :string,   :limit => 10,  :default => "",    :null => false
    t.column "display_name",  :string,   :limit => 50
    t.column "title",         :string,   :limit => 30
    t.column "avatar_file",   :string,   :limit => 44
    t.column "office_number", :string,   :limit => 20
    t.column "fax_number",    :string,   :limit => 20
    t.column "mobile_number", :string,   :limit => 20
    t.column "home_number",   :string,   :limit => 20
    t.column "timezone",      :float,                   :default => 0.0,   :null => false
    t.column "created_on",    :datetime,                                   :null => false
    t.column "created_by_id", :integer,  :limit => 10
    t.column "updated_on",    :datetime
    t.column "last_login",    :datetime
    t.column "last_visit",    :datetime
    t.column "last_activity", :datetime
    t.column "is_admin",      :boolean
    t.column "auto_assign",   :boolean,                 :default => false, :null => false
    t.column "identity_url",  :string
  end

  add_index "users", ["username"], :name => "username", :unique => true
  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["last_visit"], :name => "last_visit"
  add_index "users", ["company_id"], :name => "company_id"
  add_index "users", ["last_login"], :name => "last_login"

end