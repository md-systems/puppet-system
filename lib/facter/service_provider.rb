# == Fact: service_provider
#
# Extracts the service_provider fragment from the location.
#
Facter.add('service_provider') do
  setcode do
    location = Facter.value('location')
    if location.include? '-'
      location.split('-').shift
    end
  end
end
