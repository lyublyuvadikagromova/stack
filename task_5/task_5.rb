def valid_ip?(ip)
  parts = ip.split('.')
  return false if parts.length != 4
  parts.each do |part|
    return false unless part.match?(/^\d+$/)
    return false if part.to_i < 0 || part.to_i > 255 || part != part.to_i.to_s
  end
  true
end
puts valid_ip?("192.168.1.1")
puts valid_ip?("0.251.25.")
puts valid_ip?("192.168.01.1")
puts valid_ip?("123.456.78.90")


