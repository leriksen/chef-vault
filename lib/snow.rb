require 'json'

class Snow

  def initialize(json_file)
    @data = JSON.parse File.read(json_file)
  end

  def app_id
     @data['data']['appIdTag']
  end

  def env(domain_root)
    hostname = @data['data']['hostname']

    env = hostname.match /(\w+)#{domain_root}/
    env.nil? ? nil : env[1]
  end
end