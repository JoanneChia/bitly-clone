require 'securerandom'

a = SecureRandom.hex(10)
b = SecureRandom.base64(10)
c = SecureRandom.urlsafe_base64(10)

puts a
puts b
puts c
