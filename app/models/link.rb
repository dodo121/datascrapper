class Link < ActiveRecord::Base
  belongs_to :query
  has_many :positions

  def check_seo_change
    if self.positions.empty? || self.positions.size == 1
      self.seo_change = 'none'
    else
      case self.positions.last(2)[0].number <=> self.positions.last(2)[1].number
      when 1
        self.seo_change = 'up'
      when -1
        self.seo_change = 'down'
      else
        self.seo_change = 'none'
      end
    end
    self.save!
  end
end
