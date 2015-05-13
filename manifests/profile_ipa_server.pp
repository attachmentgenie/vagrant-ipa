class profile_ipa_server {
  class { 'ipa':
    master  => true,
    domain  => 'ipa.vagrant',
    realm   => 'IPA.VAGRANT',
    adminpw => 'secret12',
    dspw    => 'secret12',
  }
}