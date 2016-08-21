require "ffi"
require "ffi-rc4/version"
require "base64"

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

  end

  def self.decrypt_base64(encrypted_base64, secret = ::FFI_RC4.default)

  end

  def self.encrypt(text, secret = ::FFI_RC4.default)

  end

  def self.encrypt_and_base64(text, secret = ::FFI_RC4.default)

  end
end
