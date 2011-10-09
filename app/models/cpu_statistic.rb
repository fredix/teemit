class CpuStatistic
  include Mongoid::Document
  include Mongoid::Timestamps
  cache

  belongs_to_related :host

  field :user, :type => Float, :default => 0.0
  field :sys, :type => Float, :default => 0.0
  field :nice, :type => Float, :default => 0.0
  field :idle, :type => Float, :default => 0.0
  field :wait, :type => Float, :default => 0.0
  field :irq, :type => Float, :default => 0.0
  field :soft_irq, :type => Float, :default => 0.0
  field :stolen, :type => Float, :default => 0.0
  field :combined, :type => Float, :default => 0.0
  field :total, :type => Float, :default => 0.0

  index :host_id, :unique => true, :background => true

  def created_at_to_date
    return self.created_at.to_date
  end

  class << self

    def two_weeks_ago_before_last(host)
      last_stat = host.cpu_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 2.weeks

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end

    def one_week_ago_before_last(host)
      last_stat = host.cpu_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.week

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def three_days_ago_before_last(host)
      last_stat = host.cpu_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 3.days

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def one_days_ago_before_last(host)
      last_stat = host.cpu_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.days

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end


    def one_month_ago_before_last(host)
      last_stat = host.cpu_statistics.order_by([[:created_at, :desc]]).first
      date_calc = last_stat.created_at - 1.month

      where(:created_at.gte => date_calc ).order_by([[:created_at, :asc]])
    end




  end


end
