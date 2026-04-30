# frozen_string_literal: true

RSpec.describe Address, type: :model do
  context 'with relations' do
    it { should belong_to(:weather) }
  end

  context 'with validations' do
    it { should validate_presence_of(:full) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
    it { should validate_length_of(:lat).is_at_most(32) }
    it { should validate_length_of(:lng).is_at_most(32) }
  end
end
