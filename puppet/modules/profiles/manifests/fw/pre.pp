# Class: profiles::fw::pre
#
#
class profiles::fw::pre {
  Firewall {
    require => undef,
  }

  firewall { '000 accept all icmp':
    chain  => 'INPUT',
    proto  => 'icmp',
    action => 'accept',
  }

  firewall { '001 accept all to lo interface':
    chain   => 'INPUT',
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }

  firewall { '003 accept related established rules':
    chain  => 'INPUT',
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
}
