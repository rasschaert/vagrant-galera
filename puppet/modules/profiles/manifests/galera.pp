# Class: profiles::galera
#
#
class profiles::galera (
  $root_password   = '',
  $cluster_members = [],
  $sst_password    = '',
  $interface       = 'eth0',
) {
  ########
  # SNMP #
  ########
  $snmp_allowed_hosts = concat(['127.0.0.1'], $cluster_members)
  class { 'snmp::server':
    syslocation   => 'Vagrant',
    syscontact    => 'Admin <admin@example.com>',
    allowed_hosts => $snmp_allowed_hosts,
  }
  include snmp::client

  ###########
  # MariaDB #
  ###########
  class { 'xtrabackup':
    dbuser    => 'root',
    dbpass    => $root_password,
    outputdir => '/mnt/storage/backups/mariadb',
    cronjob   => false,
  }

  Class['xtrabackup'] -> Class['mariadb']

  $node_address = inline_template("<%= scope.lookupvar('::ipaddress_${interface}') -%>")
  class { 'mariadb':
    root_password   => $root_password,
    galera          => true,
    sst_password    => $sst_password,
    cluster_members => $cluster_members,
    node_address    => $node_address,
  }

  #############
  # Firewalld #
  #############
  firewalld::service { 'snmp':
    description => 'snmp service',
    ports       => [{port => '161', protocol => 'udp',},],
  }

  firewalld::service { 'mariadb':
    description => 'mariadb service',
    ports       => [{port => '3306', protocol => 'tcp',},],
  }

  Firewalld::Service<| |> -> Class['mariadb']
}
