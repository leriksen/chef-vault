require 'json'


class Snow

  def initialize(json_file)
    @data = JSON.parse File.read(json_file)

    if not @data.has_key?('data') or not @data['data'].has_key?('appIdTag') or not @data['data'].has_key?('hostname')
      raise Snow::BadSnow.new "#{json_file} is missing required appIdTag or hostname attributes"
    end
  end

  def app_id
     @data['data']['appIdTag']
  end

  def env(domain_root)
    hostname = @data['data']['hostname']

    env = hostname.match /(\w+)#{domain_root}/
    env.nil? ? nil : env[1]
  end

  class BadSnow < StandardError
    def initialize(msg="Bad Snow file")
      super
    end
  end
end
