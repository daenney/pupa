Facter.add(:cloud_provider) do
  if File.exists?('/etc/digitalocean')
    setcode 'digitalocean'
  end
end
