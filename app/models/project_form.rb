=begin
RailsCollab
-----------

=end

class ProjectForm < ActiveRecord::Base
	include ActionController::UrlWriter
	
	belongs_to :project

	belongs_to :created_by, :class_name => 'User', :foreign_key => 'created_by_id'
	belongs_to :updated_by, :class_name => 'User', :foreign_key => 'updated_by_id'
	
	before_create :process_params
	before_update :process_update_params
	 
	def process_params
	  write_attribute("created_on", Time.now.utc)
	end
	
	def process_update_params
	  write_attribute("updated_on", Time.now.utc)
	end
	
	def object_name
		self.name
	end
	
	def object_url
		url_for :only_path => true, :controller => 'form', :action => 'submit', :id => self.id, :active_project => self.project_id
	end
	
	def in_object
		return nil if (self.in_object_id == nil or self.in_object_id == 0)
		
		if self.action == :add_comment
			ProjectMessage.find(self.in_object_id)
		elsif self.action == :add_task
			ProjectTaskList.find(self.in_object_id)
		else
			nil
		end
	end
	
	def in_object=(value)
		write_attribute("in_object_id", value.id)
	end
	
	# Assignment for actions
	
	def add_comment_object
		self.action == :add_comment ? self.in_object_id : 0
	end
	
	def add_comment_object=(val)
		if self.action == :add_comment
			self.in_object_id = val
		end
	end
	
	def add_task_object
		self.action == :add_task ? self.in_object_id : 0
	end
	
	def add_task_object=(val)
		if self.action == :add_task
			self.in_object_id = val
		end
	end
		
	# Core Permissions
	
	def self.can_be_created_by(user, project)
	  return (project.has_member(user) and user.is_admin)
	end
	
	def can_be_edited_by(user)
	 if (!self.project.has_member(user))
	   return false
	 end
	 
	 if user.is_admin
	   return true
	 end
	 
	 return false
    end

	def can_be_deleted_by(user)
	 if !self.project.has_member(user)
	   return false
	 end
	 
	 if user.is_admin
	   return true
	 end
	 
	 return false
    end
    
	def can_be_seen_by(user)
	 if !self.project.has_member(user)
	   return false
	 end
	 
	 if user.is_admin
	   return true
	 end
	 
	 if self.is_private and !user.member_of_owner?
	   return false
	 end
	 
	 return true
    end
	
	# Specific Permissions

	def can_be_submitted_by(user)
		return (self.can_be_seen_by(user) and self.is_enabled)
	end
	
	# Helpers
	
	def submit(attribs, user)
		rel_object = self.in_object
		
		if !rel_object.nil?
			# Note that this might be better as a case if there were more than 2 actions
			if self.action == :add_comment
				new_comment = Comment.new(:text => attribs[:content])
				new_comment.rel_object = rel_object
				new_comment.created_by = user
				
				if new_comment.save
					ApplicationLog.new_log(new_comment, @logged_user, :add, rel_object.is_private, rel_object.project)
					true
				else
					false
				end
			elsif self.action == :add_task
				new_task = ProjectTask.new(:text => attribs[:content])
				new_task.task_list = rel_object
				new_task.created_by = user
				
				if new_task.save
					ApplicationLog.new_log(new_task, @logged_user, :add, rel_object.is_private, rel_object.project)
					true
				else
					false
				end
			end
		else
			false
		end
	end
	
	# Accesibility
	
	attr_accessible :name, :description, :success_message, :action, :is_enabled, :is_visible, :add_comment_object, :add_task_object
	
	# Validation
	
	validates_presence_of :name
end