# == Fact: device_function
#
# Extracts the device_function fragment from the hostname.
#
Facter.add('device_function') do
  setcode do
    location = Facter.value('hostname')
    location[4..5]
  end
end
