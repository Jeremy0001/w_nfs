require 'spec_helper'

if interface('eth1').has_ipv4_address?('172.31.3.12')
  describe 'nfs client' do
    describe package('nfs-common') do
      it { should be_installed }
    end

    describe user('www-data') do
      it { should exist }
      it { should have_uid 33 }
    end

    describe port(111) do
      it { should be_listening }
    end

    describe port(32_765) do
      it { should be_listening }
    end

    describe 'file should be synced between client & server '\
             'with www-data as owner' do
      describe file('/exports/data/testfile1') do
        it { should be_file }
        it { should be_owned_by 'www-data' }
      end
    end
  end
end
