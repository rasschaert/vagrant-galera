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
}
