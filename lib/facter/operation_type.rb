# == Fact: operation_type
#
# Extracts the operation_type fragment from the hostname.
#
Facter.add('operation_type') do
  setcode do
    location = Facter.value('hostname')
    case location[8]
      when 'p'
        'physical'
      when 'v'
        'virtual'
    end
  end
end
