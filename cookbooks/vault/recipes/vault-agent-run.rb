systemd_unit node[:vault][:agent_config][:service_name] do
  content(
    {
      Unit: {
        Description: 'Vault',
        Documentation: 'https://vaultproject.io/docs',
        ConditionNotEmpty: node[:vault][:agent_config][:config],
        Requires: 'network.target',
        After: 'network.target',
        StartLimitIntervalSec: '30',
        StartLimitBurst: '3'
      },
      Service: {
        PermissionsStartOnly: true,
        ExecStart: '/usr/bin/vault agent -config ' +  node[:vault][:agent_config][:config],
        ExecReload: 'kill -HUP $MAINPID',
        KillMode: 'process',
        KillSignal: 'SIGTERM',
        TimeoutStopSec: '30',
        LimitMEMLOCK: 'infinity',
        Restart: 'on-failure',
        User:  node[:accounts][:vault][:unix_user],
        Group: node[:accounts][:vault][:unix_group],
      },
      Install: {
        WantedBy: 'multi-user.target',
      }
    }
  )
  action [:create, :enable, :start]
end
