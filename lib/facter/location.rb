# == Fact: location
#
# A custom fact that extracts the location from the domain.
# It is assumed the the location fragment is at the third level od the domain.
#
Facter.add('location') do
  setcode do
    domain = Facter.value('domain')
    fragments = domain.split('.')
    fragments.pop
    fragments.pop
    fragments.pop
  end
end
