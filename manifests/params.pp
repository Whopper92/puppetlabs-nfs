class nfs::params {

  case $operatingsystem {
    "ubuntu": {
      $nfsclientpackage     = "nfs-common"
      $portmappackage       => $lsbdistcodename ? {
        "jaunty"            => "portmap",
        "lucid"             => "portmap",
        "natty"             => "portmap",
        default             => "rpcbind",
      }
      $portmapservice       = "portmap"
      $idmapservice         = "idmapd"
      $statservice          = "statd"
      $nfscommonfile        = "/etc/default/nfs-common"
      $idmapdconffile       = "/etc/idmapd.conf"
    }
  }
}
