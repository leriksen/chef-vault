require 'snow'

describe Snow do
  snow = Snow.new './spec/fixture_snow.json'
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
