# == Fact: datacenter
#
# Extracts the datacenter fragment from the location.
#
Facter.add('datacenter') do
  setcode do
    location = Facter.value('location')
    if location.include? '-'
      fragments = location.split('-')
      fragments.shift
      fragments.join '-'
    end
  end
end
