class shorewall {

  package { shorewall: ensure => latest }

  file { "/etc/shorewall":
    ensure => directory,
    source => "puppet:///files/shorewall/$fqdn",
    require => Package[shorewall],
    recurse => true,
    notify => Service[shorewall],
    # usefull for sandbox
    links => follow
  }

  file { "/etc/default/shorewall":
    source => "puppet:///shorewall/shorewall.default",
    notify => Service[shorewall]
  }

  service { shorewall:
    ensure => running,
    require => Package[shorewall],
    hasrestart => true,
    status => '/sbin/shorewall status'
  }

}
