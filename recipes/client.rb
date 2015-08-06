include_recipe 'nfs::client4'

directory node['nfs']['directory'] do
  owner 'root'
  group 'root'
  mode 00777
end

if node['nfs']['subtree_enabled']
  directory node['nfs']['subtree'] do
    owner 'www-data'
    group 'www-data'
    mode 00777
  end
end

# This is to resolve slow network connection and are not establishing mount at reboot https://help.ubuntu.com/community/NFSv4Howto
mount node['nfs']['directory'] do
  device node['nfs']['nfs_server_ip'] + ":#{node['nfs']['directory']}"
  fstype 'nfs'
  options 'rw,noauto'
  pass 0
  action [ :mount, :enable]
end

if node['nfs']['subtree_enabled']
  mount node['nfs']['subtree'] do
    device node['nfs']['nfs_server_ip'] + ":#{node['nfs']['directory']}#{node['nfs']['subtree']}"
    fstype 'nfs'
    options 'rw,noauto'
    pass 0
    action [ :mount, :enable]
  end
end

mount = <<EOF
#!/bin/sh -e
sleep 5
mount #{node['nfs']['directory']}
exit 0
EOF

file '/etc/rc.local' do
  content mount
end