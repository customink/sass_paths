# SassPaths

This gem provides helper methods for appending directories and gems to the `SASS_PATH` environment variable. This enables you to load
projects that do not themselves register with SASS.

## Installation

Add this line to your application's Gemfile:


```ruby
gem 'sass_paths'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install sass_paths
```

## Usage

#### Directories

To append a directory, simply call `append` with your list of directories that
you'd like appended.

```ruby
SassPaths.append('/my/first/sass/path', '/my/second/sass/path', ...)
```

#### Gems

In order to append a gem, call `append_gem_path` with the name of the gem as
well as the directory within the gem that contains the Sass files.

```ruby
SassPaths.append_gem_path(gem_name, directory)
```

#### Temporary Replacements

Sometimes it can be fun to change the Sass paths for the duration of a block. For example, this would swap out using [Neat](http://neat.bourbon.io) versions.

```ruby
replacements = {
  "/gems/neat-1.8.0/app/assets/stylesheets" => "/gems/neat-2.0.0/core"
}
SassPaths.with_replacements(replacements) do
  options = { load_paths: Sass.load_paths }
  Sass::Engine.new(template, options).render
end
```

The `with_replacements` takes no responsiblity for knowing about the paths passed in as being valid or not.


### Rails

Create an initializer and utilize the above methods.

### Not Rails

Use the above methods in some part of your application's boot process.

## Testing

* Run `bundle install` to install development dependencies.
* Run `rake test` to run all tests.
