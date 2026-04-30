# frozen_string_literal: true

RSpec.describe Address::UpdateWeather do
  let(:weather) { FactoryBot.create(:weather) }
  let(:address) { FactoryBot.create(:address, weather:) }
  let(:forecast_data) do
    {
      'temperature' => 72.5,
      'windspeed'   => 10.0,
      'weathercode' => 1
    }
  end
  let(:service) { described_class.new(address.id) }

  describe '#perform' do
    let(:client) { instance_double(Weather::OpenMeteoClient) }

    before do
      allow(Weather::OpenMeteoClient).to receive(:new).with(address.lat, address.lng).and_return(client)
    end

    context 'when the client returns forecast data' do
      before { allow(client).to receive(:perform).and_return(forecast_data) }

      it 'returns the address' do
        expect(service.perform).to eq address
      end

      it 'updates the weather forecast' do
        expect { service.perform }.to change { weather.reload.forecast }.to(forecast_data)
      end
    end

    context 'when the client returns nil' do
      before { allow(client).to receive(:perform).and_return(nil) }

      it 'returns false' do
        expect(service.perform).to be_falsey
      end

      it 'does not update the weather forecast' do
        expect { service.perform }.not_to change { weather.reload.forecast }
      end
    end

    context 'when the client returns an empty hash' do
      before { allow(client).to receive(:perform).and_return({}) }

      it 'returns false' do
        expect(service.perform).to be_falsey
      end

      it 'does not update the weather forecast' do
        expect { service.perform }.not_to change { weather.reload.forecast }
      end
    end
  end

  describe '#perform with invalid address id' do
    subject(:service) { described_class.new(-1) }

    it 'raises ActiveRecord::RecordNotFound' do
      expect { service.perform }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
