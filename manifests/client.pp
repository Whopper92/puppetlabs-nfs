class nfs::client {

  package {
    "nfs-common":
      name   => "${nfs::params::nfsclientpackage}",
      ensure => present;
    "portmap":
      name   => "${nfs::params::portmappackage}",
      ensure => present;
  }

  service {
    "portmap":
      name        => "${nfs::params::portmapservice}",
      ensure      => running,
      enable      => true,
      hasstatus   => true,
      hasrestart  => true,
      require     => Package["portmap"];
    "idmapd":
      name        => "${nfs::params::idmapservice}",
      ensure      => running,
      enable      => true,
      pattern     => "rpc.idmapd",
      hasrestart  => true,
      require     => Package["nfs-common"];
    "statd":
      name        => "${nfs::params::statservice}",
      ensure      => running,
      enable      => true,
      hasstatus   => true,
      hasrestart  => true,
      require     => Package["nfs-common"];
  }

  file { "nfs-common":
    name    => "${nfs::params::nfscommonfile}",
    owner   => "root",
    group   => "root",
    mode    => "0644",
    ensure  => present,
    source  => "puppet://$server/modules/nfs/etc/default/nfs-common",
  }

  file { "idmapd.conf":
    name    => "${nfs::params::idmapconffile}",
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "0644",
    notify  => Service["idmapd"],
    source  => template(nfs/idmapdconf),
  }
}
