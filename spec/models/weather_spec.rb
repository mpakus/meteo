# frozen_string_literal: true

RSpec.describe Weather, type: :model do
  describe '#need_update?' do
    subject { weather.need_update? }

    context 'when updated_at is more than 30 minutes ago' do
      let(:weather) { FactoryBot.create(:weather, updated_at: 31.minutes.ago) }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'when .forecast is blank' do
      let(:weather) { FactoryBot.create(:weather, forecast: nil) }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'when updated_at is within the last 30 minutes and forecast is present' do
      let(:weather) { FactoryBot.create(:weather, updated_at: 10.minutes.ago, forecast: { temp: 70 }) }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end
  end

  describe '#temperature' do
    context 'when have value' do
      let(:weather) { FactoryBot.create(:weather, forecast: { 'temperature' => 70.123 }).decorate }

      it 'returns formatted temperature string' do
        expect(weather.temperature).to eq I18n.t('weather.temperature.fahrenheit', temperature: 70.1)
      end
    end

    context 'when no value' do
      let(:weather) { FactoryBot.create(:weather, forecast: nil).decorate }

      it 'returns empty string if forecast is blank' do
        expect(weather.temperature).to be_empty
      end
    end
  end

  describe '#state' do
    context 'when have value' do
      let(:weather) { FactoryBot.create(:weather, forecast: { 'weathercode' => 1 }).decorate }

      it 'returns formatted state string' do
        expect(weather.state).to eq I18n.t('weather.codes.1')
      end
    end

    context 'when no value' do
      let(:weather) { FactoryBot.create(:weather, forecast: nil).decorate }

      it 'returns empty string if forecast is blank' do
        expect(weather.state).to be_empty
      end
    end
  end
end
