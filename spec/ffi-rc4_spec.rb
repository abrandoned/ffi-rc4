require 'spec_helper'

describe FFI_RC4 do
  it 'has a version number' do
    expect(FFI_RC4::VERSION).not_to be nil
  end

  it 'decrypts an encrypted value with the same secret' do
    expect(FFI_RC4::decrypt(FFI_RC4::encrypt("hello", "secret"), "secret")).to eq("hello")
  end

  it 'decrypts a base64 value encrypted with the same secret' do
    expect(FFI_RC4::decrypt_base64(FFI_RC4::encrypt_base64("hello", "secret"), "secret")).to eq("hello")
  end

  it 'respects the FFI_RC4.default value for secret key' do
    FFI_RC4.default = "secret"
    expect(FFI_RC4::decrypt_base64(FFI_RC4::encrypt_base64("hello"))).to eq("hello")
    FFI_RC4.default = nil
  end

  it 'raises an argment error if no secret or FFI_RC4.default is set' do
    FFI_RC4.default = nil
    expect { FFI_RC4::decrypt_base64(FFI_RC4::encrypt_base64("hello")) }.to raise_error(ArgumentError)
  end
end
