# GitRev

Retrieve the SHA-1 hash of the current revision of a Git repository. GitRev
uses the contents of the `.git` directory therefore it does not require Git to
be installed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_rev'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_rev

## Usage

### SHA-1

By default, `GitRev::Sha` uses the current directory as the Git repository and
caches the revision number:

```ruby
require 'git_rev'

revision = GitRev::Sha.new

revision.full
#=> 1f7995f701d02f2f62b2e7faa91a1e16f3d68666

revision.short
#=> 1f7995f
```

You may specify the location of the Git repository:

```ruby
revision = GitRev::Sha.new(repository: '/path/to/repository')
```

By default, the cache is enabled, meaning GitRev will only query the filesystem
once. If you need to ensure the revision info is reloaded each time:

```ruby
revision = GitRev::Sha.new(repository: '/path/to/repository', cache: false)

revision.short
#=> 1f7995f

`git commit -m "A message"`

revision.short
# => 658f674

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/git_rev/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
