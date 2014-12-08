# Class: profiles::fw
#
#
class profiles::fw {
  resources { 'firewall':
    purge   => true,
  }

  include profiles::fw::pre
  include profiles::fw::post
  Class['profiles::fw::pre'] -> Firewall<| |> -> Class['profiles::fw::post']
}
