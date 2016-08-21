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
end
