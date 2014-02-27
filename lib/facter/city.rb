# == Fact: city
#
# Extracts the city fragment from the location.
#
Facter.add('city') do
  setcode do
    location = Facter.value('location')
    unless location.include? '-'
      location[2..3]
    end
  end
end
