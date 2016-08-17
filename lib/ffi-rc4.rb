require "ffi"

module FFI_RC4
  VERSION = "0.1.0"

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
end
