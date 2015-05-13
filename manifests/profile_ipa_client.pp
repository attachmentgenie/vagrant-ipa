class profile_ipa_client {
  class { 'ipa':
    client     => true,
    domain     => 'ipa.vagrant',
    desc       => 'This is an IPA client',
    ipaservers => ['server.ipa.vagrant'],
    mkhomedir  => true,
    otp        => 'one_time_passwd',
    realm      => 'IPA.VAGRANT',
  }
}