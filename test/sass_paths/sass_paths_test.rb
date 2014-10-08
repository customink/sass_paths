require 'test_helper'

module SassPaths
  describe '#append' do
    it 'appends path to SASS_PATH ENV with existing paths' do
      ENV['SASS_PATH'] = 'some/file/directory:another/directory'
      SassPaths.append('test/directory')
      assert_equal 'some/file/directory:another/directory:test/directory', ENV['SASS_PATH']
    end

    it 'appends without duplicates' do
      ENV['SASS_PATH'] = 'one/directory:duplicate/directory'
      SassPaths.append('duplicate/directory')
      assert_equal 'one/directory:duplicate/directory', ENV['SASS_PATH']
    end

    it 'appends to empty SASS_PATH ENV' do
      ENV['SASS_PATH'] = ''
      SassPaths.append('test/directory')
      assert_equal 'test/directory', ENV['SASS_PATH']
    end
  end

  describe '#append_gem_path' do
    it 'appends gem path to SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'some/file/directory:another/directory'
      SassPaths.append_gem_path('susy', 'sass')
      assert ENV['SASS_PATH'].include? 'some/file/directory:another/directory'
      assert ENV['SASS_PATH'].match /gems\/susy-[\d\.]+\/sass/
    end
  end

  describe '#append_bower_components' do
    it 'appends bower paths to SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'some/file/directory:another/directory'
      SassPaths.append_bower_components('.')
      assert ENV['SASS_PATH'].include? 'some/file/directory:another/directory'
      assert ENV['SASS_PATH'].match /bower_components\/susy\/sass/
      assert ENV['SASS_PATH'].match /bower_components\/sassy-maps\/sass/
      refute ENV['SASS_PATH'].match /bower_components\/jquery/
    end
  end

  describe '#env_path' do
    it 'returns SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'test/directory'
      assert_equal 'test/directory', SassPaths.env_path
    end
  end

  describe '#reload_paths!' do
    it 'reloads the SASS_PATH' do
      ENV['SASS_PATH'] = 'some/file/directory:another/directory'
      SassPaths.reload_paths!
      assert_equal ['some/file/directory', 'another/directory'], Sass.load_paths
      assert_equal 'some/file/directory:another/directory', ENV['SASS_PATH']
    end
  end

end
