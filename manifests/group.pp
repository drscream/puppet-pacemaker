define pacemaker::group (
  $params,
  $shadow_cib = $pacemaker::shadow_cib
) {
  include pacemaker

  file{"${pacemaker::cib_pool}/group-${name}":
    ensure  => present,
    content => template('pacemaker/group.erb'),
    notify  => Class['pacemaker::commit'],
  }

  exec{"group-${name}":
    path        => '/bin:/usr/sbin',
    command     => "sh ${pacemaker::cib_pool}/group-${name}",
    require     => File["${pacemaker::cib_pool}/group-${name}"],
    refreshonly => true,
    subscribe   => File["${pacemaker::cib_pool}/group-${name}"],
  }
}

