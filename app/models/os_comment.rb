class OsComment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, :type => String
  field :note, :type => Integer, :default => 0

  belongs_to_related :osystem

  def created_at_to_date
    return self.created_at.to_date
  end
end
