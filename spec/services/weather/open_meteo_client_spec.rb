# frozen_string_literal: true

RSpec.describe Weather::OpenMeteoClient, type: :webmock do
  let(:latitude) { '30.2746912' }
  let(:longitude) { '-97.7405171' }
  let(:client) { described_class.new(latitude, longitude) }

  describe '#perform' do
    let(:args) do
      {
        latitude:,
        longitude:,
        temperature_unit: 'fahrenheit',
        current_weather:  true
      }
    end
    let(:url) { "#{described_class::URL}?#{args.to_query}" }
    let(:current_weather) do
      {
        'time'          => '2026-04-29T22:30',
        'interval'      => 900,
        'temperature'   => 68.0,
        'windspeed'     => 10.5,
        'winddirection' => 22,
        'is_day'        => 1,
        'weathercode'   => 3
      }
    end

    context 'when contract returns :ok and json' do
      before do
        stub_request(:get, url).to_return(
          status: 200,
          body: { current_weather: }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it 'calls the API with correct URL and arguments' do
        client.perform
        expect(WebMock).to have_requested(:get, url).once
      end

      it 'returns correct json' do
        expect(client.perform).to eq current_weather
      end
    end

    context 'when the service returns 5xx' do
      let(:error_message) { 'Internal Server Error' }
      before do
        stub_request(:get, url).to_return(status: 500, body: error_message)
        client.perform
      end

      it 'returns client.status to 500' do
        expect(client.status).to eq 500
      end
      it 'returns client.error to the error message' do
        expect(client.error).to eq error_message
      end
    end

    context 'when the network fails' do
      before do
        stub_request(:get, url).to_raise(SocketError)
        client.perform
      end

      it 'returns client.status to :exception' do
        expect(client.status).to eq :exception
      end
      it 'return client.error message' do
        expect(client.error).to_not be_empty
      end
    end
  end
end
