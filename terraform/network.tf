resource "openstack_networking_network_v2" "phani_net" {
  name = "phani-net"
  region = "${var.os_region}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "phani_subnet" {
  network_id = "${openstack_networking_network_v2.phani_net.id}"
  region = "${var.os_region}"
  cidr = "${var.phani_subnet_cidr}"
  ip_version = 4
  enable_dhcp = true
  dns_nameservers = [
    "10.181.227.181"
  ]
}
