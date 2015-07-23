Facter.add(:cloud_provider) do
  if File.exists?('/etc/digitalocean') do
    setcode 'digitalocean'
  end
end
