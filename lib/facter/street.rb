# == Fact: street
#
# Extracts the street fragment from the location.
#
Facter.add('street') do
  setcode do
    location = Facter.value('location')
    unless location.include? '-'
      location[4..-1]
    end
  end
end
