class HostComment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, :type => Integer 
  field :comment, :type => String
  field :note, :type => Integer, :default => 0

  belongs_to_related :host

  def created_at_to_date
    return self.created_at.to_date
  end
end
