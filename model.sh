#!/usr/bin/env bats

@test "member can get into club" {
  run sshpass -pqzwxecrv ssh member@club.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
  [ $output == '/home/member' ]
}

@test "member can not get into lounge" {
  run sshpass -pqzwxecrv ssh member@lounge.ipa.vagrant -f 'pwd'
  [ $status -eq 255 ]
}

@test "member can not get into office" {
  run sshpass -pqzwxecrv ssh member@office.ipa.vagrant -f 'pwd'
  [ $status -eq 255 ]
}

@test "vip can get into club" {
  run sshpass -pqzwxecrv ssh vip@club.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
  [ $output == '/home/vip' ]
}

@test "vip can get into lounge" {
  run sshpass -pqzwxecrv ssh vip@lounge.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
}

@test "vip can not get into office" {
  run sshpass -pqzwxecrv ssh vip@office.ipa.vagrant -f 'pwd'
  [ $status -eq 255 ]
}

@test "bouncer can get into club" {
  run sshpass -pqzwxecrv ssh bouncer@club.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
  [ $output == '/home/bouncer' ]
}

@test "bouncer can get into lounge" {
  run sshpass -pqzwxecrv ssh bouncer@lounge.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
}

@test "bouncer can get into office" {
  run sshpass -pqzwxecrv ssh bouncer@office.ipa.vagrant -f 'pwd'
  [ $status -eq 0 ]
}
