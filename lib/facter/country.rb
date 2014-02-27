# == Fact: country
#
# Extracts the country fragment from the location.
#
Facter.add('country') do
  setcode do
    location = Facter.value('location')
    unless location.include? '-'
      location[0..1]
    end
  end
end
