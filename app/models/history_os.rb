class HistoryOs
  include Mongoid::Document
  include Mongoid::Timestamps

  field :architecture, :type => String
  field :counter, :type => Integer

end
