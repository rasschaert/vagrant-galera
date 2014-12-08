# Class: profiles::base
#
#
class profiles::base {
  package { 'vim':
    ensure => installed,
  }
  package { 'mlocate':
    ensure => installed,
  }
  package { 'tree':
    ensure => installed,
  }
  # Until a proper openssh module is included
  firewall { '100 allow ssh':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '22',
    proto  => 'tcp',
    action => 'accept',
  }
}
