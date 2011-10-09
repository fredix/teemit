class LoadStatistic
  include Mongoid::Document
  include Mongoid::Timestamps
  cache

  belongs_to_related :host

  field :loadavg0, :type => Float, :default => 0.0
  field :loadavg1, :type => Float, :default => 0.0
  field :loadavg2, :type => Float, :default => 0.0

  index :host_id, :unique => true, :background => true

  def created_at_to_date
    return self.created_at.to_date
  end

  class << self

    def two_weeks_ago_before_last(host)
      last_stat = host.load_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 2.weeks

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end

    def one_week_ago_before_last(host)
      last_stat = host.load_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.week

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def three_days_ago_before_last(host)
      last_stat = host.load_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 3.days

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def one_days_ago_before_last(host)
      last_stat = host.load_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.days

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def one_month_ago_before_last(host)
      last_stat = host.load_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.month

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end




  end



end
