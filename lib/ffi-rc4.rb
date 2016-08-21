require "ffi"
require "ffi-rc4/version"
require "base64"
require "digest"

module FFI_RC4
  extend FFI::Library
  if FFI::Platform.windows?
    ffi_lib 'libeay32', 'ssleay32'
  else
    ffi_lib 'ssl'
  end

  class RC4_KEY < FFI::Struct
    layout :x => :uint,
      :y => :uint,
      :data => [:uint, 256]
  end

  attach_function :RC4_set_key, [:pointer, :int, :pointer], :void, :blocking => true
  attach_function :RC4, [:pointer, :int, :pointer, :pointer], :void, :blocking => true

  def self.default
    @default || nil
  end

  def self.default=(value)
    @default = value
  end

  def self.decrypt(encrypted_bytes, secret = ::FFI_RC4.default)
    raise ArgumentError, "secret cannot be nil" if secret.nil?

    secret_digest = "#{::Digest::SHA256.hexdigest(secret)}#{::Digest::SHA256.hexdigest(secret.reverse)}"
    rc4_key = RC4_KEY.new
    rc4_key[:data].to_ptr.put_string(0, secret_digest)

    in_data = ::FFI::MemoryPointer.from_string(encrypted_bytes)
    out_data = ::FFI::MemoryPointer.new(:char, encrypted_bytes.length)
    secret_pointer = ::FFI::MemoryPointer.from_string(secret_digest)
    RC4_set_key(rc4_key.pointer, secret_digest.length, secret_pointer)
    RC4(rc4_key.pointer, encrypted_bytes.length, in_data, out_data)

    out_data.read_string
  end

  def self.decrypt_base64(encrypted_base64, secret = ::FFI_RC4.default)
    decrypt(::Base64::urlsafe_decode64(encrypted_base64), secret)
  end

  def self.encrypt(text, secret = ::FFI_RC4.default)
    raise ArgumentError, "secret cannot be nil" if secret.nil?

    secret_digest = "#{::Digest::SHA256.hexdigest(secret)}#{::Digest::SHA256.hexdigest(secret.reverse)}"
    rc4_key = RC4_KEY.new
    rc4_key[:data].to_ptr.put_string(0, secret_digest)

    in_data = ::FFI::MemoryPointer.from_string(text)
    out_data = ::FFI::MemoryPointer.new(:char, text.length)
    secret_pointer = ::FFI::MemoryPointer.from_string(secret_digest)
    RC4_set_key(rc4_key.pointer, secret_digest.length, secret_pointer)
    RC4(rc4_key.pointer, text.length, in_data, out_data)

    out_data.read_string
  end

  def self.encrypt_and_base64(text, secret = ::FFI_RC4.default)
    ::Base64::urlsafe_encode64(encrypt(text, secret))
  end

  class << self
    alias_method :encrypt_base64, :encrypt_and_base64
  end
end
