#
# Cookbook Name:: w_nfs
# Recipe:: default

node.override['nfs']['packages'] = %w( nfs-kernel-server )
node.override['nfs']['threads'] = 16 * node['cpu']['total']

directory node['nfs']['directory'] do
  owner 'root'
  group 'root'
  mode 00777
end

user 'www-data' do
  shell '/bin/bash'
  action :modify
end

directory node['nfs']['directory'] + node['nfs']['subtree'] do
  owner 'www-data'
  group 'www-data'
end

include_recipe 'nfs::server4'

nfs_export node['nfs']['directory'] do
  network node['nfs']['network']
  writeable true
  sync false
  options %w( insecure no_subtree_check )
end

if node['nfs']['subtree_enabled']
  nfs_export node['nfs']['directory'] + node['nfs']['subtree'] do
    network node['nfs']['network']
    writeable true
    sync false
    options %w( insecure no_subtree_check )
  end
end

firewall 'default'

[node['nfs']['port']['default'], node['nfs']['port']['statd'], node['nfs']['port']['statd_out'], node['nfs']['port']['mountd'], node['nfs']['port']['lockd'], node['nfs']['port']['rquotad']].each do |nfs_port|
	firewall_rule "nfs port #{nfs_port}" do
	  port  nfs_port
	end
end
