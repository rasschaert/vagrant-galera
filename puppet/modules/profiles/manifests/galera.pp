# Class: profiles::galera
#
#
class profiles::galera {
  contain snmp
  contain python
  contain xtrabackup
  contain mariadb
  Class['xtrabackup'] -> Class['mariadb']
  Class['python']     -> Class['mariadb']
}
