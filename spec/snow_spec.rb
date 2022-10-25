require 'snow'

describe Snow do
  context 'good snow' do

    snow = Snow.new './spec/fixtures/good_snow.json'
    it 'builds a new instance' do
      expect(snow).to be_an_instance_of(Snow)
    end

    it 'extracts the app_id' do
      expect(snow.app_id).to eq('b00841')
    end

    it 'extracts the env' do
      expect(snow.env '.aws.surface.com.au').to eq('dev')
      expect(snow.env 'breakage').to be_nil
    end
  end

  context 'bad json' do
    it 'rejects bad json files' do
      expect {Snow.new './spec/fixtures/bad_json.json'}.to raise_error(JSON::ParserError)
    end
  end

  context 'bad snow' do

    it 'rejects bad snow files' do
      expect {Snow.new './spec/fixtures/bad_snow.json'}.to raise_error(Snow::BadSnow, "./spec/fixtures/bad_snow.json is missing required appIdTag or hostname attributes")
    end
  end
end
