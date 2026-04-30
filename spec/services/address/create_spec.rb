# frozen_string_literal: true

RSpec.describe Address::Create do
  let(:address) { FactoryBot.build(:address) }
  let(:full) { address.full }
  let(:lat) { address.lat }
  let(:lng) { address.lng }
  let(:zip) { address.weather.zip }

  subject(:result) { described_class.new(full, lat, lng, zip).perform }

  describe '#perform' do
    context 'when the Address and zip are both new' do
      it 'creates the Address' do
        expect { result }.to change(Address, :count).by(1)
      end

      it 'creates the Address with the correct attributes' do
        expect(result[:address]).to have_attributes(full:, lat:, lng:)
      end

      it 'creates the Weather record and associates it' do
        expect { result }.to change(Weather, :count).by(1)
      end

      it 'creates the Weather with correct zip code' do
        expect(result[:address].weather.zip).to eq zip
      end
    end

    context 'when Weather with the same zip code already exists' do
      let!(:existing_weather) { FactoryBot.create(:weather, zip:) }

      it 'reuses the Weather' do
        expect { result }.not_to change(Weather, :count)
      end

      it 'is link the Weather with the same zip code' do
        expect(result[:address].weather.zip).to eq existing_weather.zip
      end
    end

    context 'when called twice with the same full' do
      let!(:first) { described_class.new(full, lat, lng, zip).perform }

      it 'is idempotent' do
        expect { result }.not_to change(Address, :count)
      end

      it 'returns the same Address' do
        expect(result[:address]).to eq first[:address]
      end
    end

    context 'when address validation fails' do
      let(:full) { nil }

      it 'returns an error hash' do
        expect(result).to have_key(:error)
      end

      it 'rolls back the zip creation' do
        expect { result }.not_to change(Weather, :count)
      end
    end
  end
end
