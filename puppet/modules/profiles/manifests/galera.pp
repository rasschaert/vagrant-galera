# Class: profiles::galera
#
#
class profiles::galera (
  $root_password   = '',
  $cluster_members = [],
  $sst_password    = '',
  $interface       = 'eth0',
) {
  $snmp_allowed_hosts = concat(['127.0.0.1'], $cluster_members)
  class { 'snmp::server':
    syslocation   => 'Vagrant',
    syscontact    => 'Admin <admin@example.com>',
    allowed_hosts => $snmp_allowed_hosts,
  }
  include snmp::client

  $node_address = inline_template("<%= scope.lookupvar('::ipaddress_${interface}') -%>")
  class { 'mariadb':
    root_password   => $root_password,
    galera          => true,
    sst_password    => $sst_password,
    cluster_members => $cluster_members,
    node_address    => $node_address,
  }
}
