#
# ipmess.rb
# Try to get additional Facts about the machine's network interfaces on Linux
#
# Original concept Copyright (C) 2007 psychedelys <psychedelys@gmail.com>
# Update and *BSD support (C) 2007 James Turnbull <james@lovedthanlost.net>
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation (version 2 of the License)
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston MA  02110-1301 USA
#

require 'facter/util/ip'

Facter.add(:interfaces) do
       confine :kernel => [ :sunos, :freebsd, :openbsd, :netbsd, :linux ]
       setcode do
           Facter::IPAddress.get_interfaces.join(",")
       end
end


Facter::IPAddress.get_interfaces.each do |interface|

mi = interface.gsub(':', '_')

Facter.add("ipaddress_" + mi) do
       confine :kernel => [ :sunos, :freebsd, :openbsd, :netbsd, :linux ]
       setcode do
           label = 'ipaddress'
           Facter::IPAddress.get_interface_value(interface, label)
       end
end

Facter.add("macaddress_" + mi) do
       confine :kernel => [ :sunos, :freebsd, :openbsd, :netbsd, :linux ]
       setcode do
           label = 'macaddress'
           Facter::IPAddress.get_interface_value(interface, label) 
       end
end

Facter.add("netmask_" + mi) do
       confine :kernel => [ :sunos, :freebsd, :openbsd, :netbsd, :linux ]
       setcode do
           label = 'netmask'
           Facter::IPAddress.get_interface_value(interface, label)
       end
end

end
