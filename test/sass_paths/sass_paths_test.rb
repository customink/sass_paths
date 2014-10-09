require 'test_helper'

module SassPaths
  describe '#append' do
    it 'appends path to SASS_PATH ENV with existing paths' do
      ENV['SASS_PATH'] = 'lib:lib/sass_paths'
      SassPaths.append('lib/sass_paths/rails')
      assert_equal 'lib:lib/sass_paths:lib/sass_paths/rails', ENV['SASS_PATH']
    end

    it 'appends without duplicates' do
      ENV['SASS_PATH'] = 'lib:lib/sass_paths'
      SassPaths.append('lib/sass_paths')
      assert_equal 'lib:lib/sass_paths', ENV['SASS_PATH']
    end

    it 'appends to empty SASS_PATH ENV' do
      ENV['SASS_PATH'] = ''
      SassPaths.append('lib/sass_paths')
      assert_equal 'lib/sass_paths', ENV['SASS_PATH']
    end

    it "won't append a path that does not exist" do
      ENV['SASS_PATH'] = ''
      SassPaths.append('this/is/not/a/real/path12321')
      assert_equal '', ENV['SASS_PATH']
    end
  end

  describe '#append_gem_path' do
    it 'appends gem path to SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'lib/sass_paths:lib'
      SassPaths.append_gem_path('susy', 'sass')
      assert ENV['SASS_PATH'].include? 'lib/sass_paths:lib'
      assert ENV['SASS_PATH'].match /gems\/susy-[\d\.]+\/sass/
    end
  end

  describe '#append_bower_components' do
    it 'appends bower paths to SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'lib/sass_paths:lib'
      SassPaths.append_bower_components('.')
      assert ENV['SASS_PATH'].include? 'lib/sass_paths:lib'
      assert ENV['SASS_PATH'].match /bower_components\/susy\/sass/
      assert ENV['SASS_PATH'].match /bower_components\/sassy-maps\/sass/
      refute ENV['SASS_PATH'].match /bower_components\/jquery/
    end
  end

  describe '#env_path' do
    it 'returns SASS_PATH ENV' do
      ENV['SASS_PATH'] = 'lib/sass_paths'
      assert_equal 'lib/sass_paths', SassPaths.env_path
    end
  end

  describe '#reload_paths!' do
    it 'reloads the SASS_PATH' do
      ENV['SASS_PATH'] = 'lib:lib/sass_paths'
      SassPaths.reload_paths!
      assert_equal ['lib', 'lib/sass_paths'], Sass.load_paths
      assert_equal 'lib:lib/sass_paths', ENV['SASS_PATH']
    end
  end

end
