# == Fact: device_number
#
# Extracts the device_number fragment from the hostname.
#
Facter.add('device_number') do
  setcode do
    location = Facter.value('hostname')
    location[6..7]
  end
end
