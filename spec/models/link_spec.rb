require 'rails_helper'

RSpec.describe Link, type: :model do

  describe '.check_seo_change' do

    let!(:link) { create(:link) }
    let!(:position) { create(:position, link_id: link.id) }

    def new_link_position_in_db(position_number)
      create(:position, number: position_number, link_id: link.id)
      link.check_seo_change
    end

    context 'when Link is new' do
      before { link.check_seo_change }

      it 'seo_change is none' do
        expect(link.seo_change).to eq('none')
      end
    end

    context 'when Link goes up' do
      before { new_link_position_in_db(3) }

      it 'seo_change is up' do
        expect(link.seo_change).to eq('up')
      end
    end

    context 'when Link goes down' do
      before { new_link_position_in_db(7) }

      it 'seo_change is down' do
        expect(link.seo_change).to eq('down')
      end
    end

    context 'when Link is at the same position' do
      before { new_link_position_in_db(5) }

      it 'seo_change is none' do
        expect(link.seo_change).to eq('none')
      end
    end
  end

end



#def check_seo_change
#  if self.positions.empty? || self.positions.size == 1
#    self.seo_change = 'none'
#  else
#    case self.positions.last(2)[0].number <=> self.positions.last(2)[1].number
#    when 1
#      self.seo_change = 'up'
#    when -1
#      self.seo_change = 'down'
#    else
#      self.seo_change = 'none'
#    end
#  end
#  self.save
#end
