require 'spec_helper_acceptance'

describe 'jmxtrans class', :if => fact('osfamily') == 'Debian' do
  context 'sensible parameters for a Debian system' do

    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class{'::java':}
      ->
      class { 'jmxtrans':
        package_name  => 'jmxtrans',
        service_name  => 'jmxtrans',
        package_source => 'http://central.maven.org/maven2/org/jmxtrans/jmxtrans/254/jmxtrans-254.deb'
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('jmxtrans') do
      it { is_expected.to be_installed }
    end

    describe service('jmxtrans') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
