# Mina Sneakers

[Mina](https://github.com/nadarei/mina) tasks for handle with
[Sneakers](https://github.com/jondot/sneakers).

This gem provides several mina tasks:

    mina sneakers:kill            # Kill sneakers
    mina sneakers:phased_restart  # Restart sneakers (phased restart)
    mina sneakers:restart         # Restart sneakers
    mina sneakers:start           # Start sneakers
    mina sneakers:stop            # Stop sneakers

## Installation

Add this line to your application's Gemfile:

    gem 'mina-sneakers', git: 'https://github.com/warpc/mina-sneakers', require: false

And then execute:

    $ bundle

## Usage

Add this to your `config/deploy.rb` file:

    require 'mina/sneakers'

Warning: sneakers daemon option should be true for environment which
plan to deploy using mina

## Example
```ruby
require 'mina/sneakers'

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    ...

    on :launch do
      ...
      invoke :'sneakers:phased_restart'
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
