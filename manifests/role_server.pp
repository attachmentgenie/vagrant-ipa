class role_server () {
  class { '::epel': } ->
  class { '::profile_ntp': } ->
  class { '::profile_selinux': } ->
  class { '::profile_firewall': } ->
  class { '::profile_ipa_server': }
}