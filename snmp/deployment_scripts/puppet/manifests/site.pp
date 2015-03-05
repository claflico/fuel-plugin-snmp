$fuel_settings = parseyaml(file('/etc/astute.yaml'))
$snmp_polling_port = $fuel_settings['snmp']['snmp_polling_port']
$snmp_read_community = $fuel_settings['snmp']['snmp_read_community']
$snmp_monitor_host = $fuel_settings['snmp']['snmp_monitor_host']

# Apply snmp settings
notice('PLUGIN: snmp:service')

class { 'snmp':
  agentaddress  => [ "udp:${snmp_polling_port}", "udp6:${snmp_polling_port}" ],
  ro_community  => $snmp_read_community,
  ro_community6 => $snmp_read_community,
  ro_network    => $snmp_monitor_host,
  com2sec       => [ "notConfigUser $snmp_monitor_host $snmp_read_community" ],
  com2sec6      => [ "notConfigUser $snmp_monitor_host $snmp_read_community" ],
  contact       => $fuel_settings['snmp']['snmp_contact'],
  location      => $fuel_settings['snmp']['snmp_location'],
}

# Create a firewall rule
notice('PLUGIN: snmp:firewall')

firewall {"$snmp_polling_port snmp ":
  sport   => [ $snmp_polling_port ],
  source  => $snmp_monitor_host,
  proto   => 'udp',
  action  => 'accept',
}
