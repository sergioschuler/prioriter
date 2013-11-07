class Task < ActiveRecord::Base
	belongs_to :user
	before_create :set_position

	private
  def set_position
    self.position ||= 1 + (Task.where(user_id: self.user_id, completed: false).maximum(:position) || 0)
  end
end
