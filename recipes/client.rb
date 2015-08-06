include_recipe 'nfs::client4'

#need to uncomment when needed
directory node['nfs']['subtree'] #do
  #owner node['nfs']['idmap']['user']
  #group node['nfs']['idmap']['group']
  #mode 00777
  #not_if "ls #{node['nfs']['subtree']}"
#end

# This is to resolve slow network connection and are not establishing mount at reboot https://help.ubuntu.com/community/NFSv4Howto
mount node['nfs']['subtree'] do
  device node['nfs']['nfs_server_ip'] + ":#{node['nfs']['directory']}#{node['nfs']['subtree']}"
  fstype 'nfs'
  options 'rw,noauto'
  pass 0
  action [ :mount, :enable]
end

mount_subtree = <<EOF
#!/bin/sh -e
sleep 5
mount #{node['nfs']['subtree']}
exit 0
EOF

file '/etc/rc.local' do
  content mount_subtree
end