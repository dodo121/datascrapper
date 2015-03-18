require 'rails_helper'

RSpec.describe Query, type: :model do
  it { should validate_presence_of(:name) }
end
