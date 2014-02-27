# == Fact: operation_level
#
# Extracts the operation_level fragment from the hostname.
#
Facter.add('operation_level') do
  setcode do
    location = Facter.value('hostname')
    case location[9]
      when 'd'
        'development'
      when 't'
        'testing'
      when 's'
        'staging'
      when 'p'
        'production'
    end
  end
end
