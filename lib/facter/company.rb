# == Fact: company
#
# Extracts the company fragment from the hostname.
#
Facter.add('company') do
  setcode do
    location = Facter.value('hostname')
    location[0..2]
  end
end
