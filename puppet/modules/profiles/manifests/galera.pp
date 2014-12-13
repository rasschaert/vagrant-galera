# Class: profiles::galera
#
#
class profiles::galera {
  include snmp::server
  include snmp::client
  include python
  include xtrabackup
  include mariadb
  Class['xtrabackup'] -> Class['mariadb']
}
