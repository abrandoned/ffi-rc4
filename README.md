# FFI::RC4

A simple FFI wrapper around openssl RC4 for unsafe RC4 encryption, **do not use for production systems if you expect anything to be considered "secure", use a better algorithm like AES-256-CBC**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ffi-rc4'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ffi-rc4

## Usage
```ruby
require 'ffi-rc4'
FFI_RC4.default = "secret" # setup a default secret if desired, each call takes a secret as well

# get back base64 encoded bytes
encrypted_base64 = FFI_RC4::encrypt_base64("hello")
text = FFI_RC4::decrypt_base64(encrypt_base64)

# or get back bytes
encrypted = FFI_RC4::encrypt("hello")
text = FFI_RC4::decrypt(encrypted)

# or send secret with call
encrypted_base64 = FFI_RC4::encrypt_base64("hello", "other_secret")
text = FFI_RC4::decrypt_base64(encrypted_base64, "other_secret")

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ffi-rc4.

