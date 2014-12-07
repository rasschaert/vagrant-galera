vagrant-galera
==============

This Vagrant environment contains three identical boxes that are each provisioned with Puppet. After they are fully provisioned, they run MariaDB and are joined in a Galera cluster.

Bootstrapping and joining of the cluster should happen automatically thanks to a Python script that is installed as a systemd unit. This script leverages SNMP to inform itself of the status and log position of the other cluster members and makes the decision to join or bootstrap based on that information.

This repository uses git submodules. Before starting Vagrant, run ```git submodule update --init``` to pull them in.
