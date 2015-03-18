require 'spec_helper'

describe GoogleSearch do
  let!(:user) { create(:user) }
  let(:method) { GoogleSearch.new.perform("ruby", user.id) }
  let(:wrong_method) { GoogleSearch.new.perform("", user.id) }

  context 'with correct params' do
    it 'incements Query count by 1' do
      VCR.use_cassette('google') do
        expect { method }.to change(Query, :count).by(1)
      end
    end

    it 'incements Link count by 9' do
      VCR.use_cassette('google') do
        expect { method }.to change(Link, :count).by(9)
      end
    end

    it 'increments User.queries count' do
      VCR.use_cassette('google') do
        expect { method }.to change(user.queries, :count).by(1)
      end
    end
  end

  context 'with wrong params' do
    it 'does not change Query count' do
      VCR.use_cassette('blank_serach') do
        expect { wrong_method }.not_to change(Query, :count)
      end
    end

    it 'does not change Link count' do
      VCR.use_cassette('blank_serach') do
        expect { wrong_method }.not_to change(Link, :count)
      end
    end

    it 'does not change User.queries count' do
      VCR.use_cassette('blank_serach') do
        expect { wrong_method }.not_to change(user.queries, :count)
      end
    end
  end

end
