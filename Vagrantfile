# generated from terraform, do not edit

require 'vagrant-aws'

require_relative 'vagrant/initializers/except.rb'

amis = {
  :rhel   => {
    :ami => 'ami-0808460885ff81045', # RHEL 8       (HVM), SSD, EBS, x86
    :user => 'ec2-user'
  },
  :aws    => {
    :ami => 'ami-067e6178c7a211324', # AWS 5.10     (HVM), SSD, EBS, x86
    :user => 'ec2-user'
  },
  :ubuntu => {
    :ami => 'ami-09a5c873bc79530d9', # Ubuntu 22.04 (HVM), SSD, EBS, x86
    :user => 'ubuntu'
  }
}

use = amis[:rhel]

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"


  config.vm.provider :aws do |aws, override|
    aws.access_key_id         = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key     = ENV['AWS_SECRET_ACCESS_KEY']

    aws.keypair_name          = 'vault'
    aws.instance_type         = 't2.micro' # 1 CPU, 1 GB
    aws.region                = 'ap-southeast-2'

    aws.region_config 'ap-southeast-2' do |region|
      region.spot_instance = true
      region.spot_max_price = "0.07"
    end

    aws.ami                   = use[:ami]

    aws.security_groups       = ['sg-044511a878b8e508b']
    aws.subnet_id             = 'subnet-05e26b72b92b32754'
    aws.associate_public_ip   = true

    aws.ssh_host_attribute    = :public_ip_address

    aws.terminate_on_shutdown = false

    override.ssh.username         = use[:user]
    override.ssh.private_key_path = './vault.pem'

    override.vm.synced_folder ".", "/vagrant", disabled: true

  end
end

