class OsLastComment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, :type => String
  field :note, :type => Integer, :default => 0

  embedded_in :osystem, :inverse_of => :os_last_comments

  def created_at_to_date
    return self.created_at.to_date
  end
end
