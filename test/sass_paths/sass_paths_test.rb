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
      assert ENV['SASS_PATH'].match(/gems\/susy-[\d\.]+\/sass/)
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

  describe '#with_replacements' do
    it 'can swap out paths' do
      neatv1 = 'neat-1.8.0/stylesheets'
      neatv2 = 'neat-2.0.0/stylesheets'
      brbnv4 = 'bourbon-4.3.3/stylesheets'
      brbnv5 = 'bourbon-5.0.0/stylesheets'
      ENV['SASS_PATH'] = "lib:#{neatv1}:lib/sass:#{brbnv4}"
      SassPaths.reload_paths!
      assert_equal 'lib',       Sass.load_paths[0]
      assert_equal neatv1,      Sass.load_paths[1]
      assert_equal 'lib/sass',  Sass.load_paths[2]
      assert_equal brbnv4,      Sass.load_paths[3]
      replacements = {
        neatv1 => neatv2,
        brbnv4 => brbnv5
      }
      SassPaths.with_replacements(replacements) do
        assert_equal 'lib',       Sass.load_paths[0]
        assert_equal neatv2,      Sass.load_paths[1]
        assert_equal 'lib/sass',  Sass.load_paths[2]
        assert_equal brbnv5,      Sass.load_paths[3]
        ENV['SASS_PATH'] = "lib:#{neatv2}:lib/sass:#{brbnv5}"
      end
      assert_equal 'lib',       Sass.load_paths[0]
      assert_equal neatv1,      Sass.load_paths[1]
      assert_equal 'lib/sass',  Sass.load_paths[2]
      assert_equal brbnv4,      Sass.load_paths[3]
      ENV['SASS_PATH'] = "lib:#{neatv1}:lib/sass:#{brbnv4}"
    end
  end
end
