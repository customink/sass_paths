# SassPaths

This gem provides helper methods for appending directories, gems, and bower
extensions to the `SASS_PATH` environment variable. This enables you to load
projects that do not themselves register with SASS.

## Installation

Add this line to your application's Gemfile:

    gem 'sass_paths'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sass_paths

## Usage

#### Directories

To append a directory, simply call `append` with your list of directories that
you'd like appended.

    SassPaths.append('/my/first/sass/path', '/my/second/sass/path', ...)

#### Gems

In order to append a gem, call `append_gem_path` with the name of the gem as
well as the directory within the gem that contains the Sass files.

    SassPaths.append_gem_path(gem_name, directory)

#### Bower Components

In order to append the Sass files within a bower components directory, call
`append_bower_components` with the name of the directory where the components
are installed. 

    SassPaths.append_bower_components('directory')

### Rails

Create an initializer and utilize the above methods.

### Not Rails

Use the above methods in some part of your application's boot process.
