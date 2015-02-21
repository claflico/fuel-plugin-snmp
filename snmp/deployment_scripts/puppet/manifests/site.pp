$fuel_settings = parseyaml(file('/etc/astute.yaml'))

# Just apply snmp settings
class { 'snmp':
  agentaddress => $fuel_settings['snmp']['snmp_polling_port'],
  rocommunity  => $fuel_settings['snmp']['snmp_read_community'],
  ro_network   => $fuel_settings['snmp']['snmp_monitor_host'],
  contact      => $fuel_settings['snmp']['snmp_contact'],
  location     => $fuel_settings['snmp']['snmp_location'],
}

