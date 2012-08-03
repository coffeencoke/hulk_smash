class UrlDataConverter
  def self.from_hash(hash)
    encode(hash)
  end

  def self.encode(value, key = nil, out_hash = {})
    case value
    when Hash  then
      value.each { |k,v| encode(v, append_key(key,k), out_hash) }
      out_hash
    when Array then
      value.each { |v| encode(v, "#{key}[]", out_hash) }
      out_hash
    when nil   then ''
    else
      out_hash[key] = value
    end
    out_hash.map{|k,v| "#{k}=#{v}" }.join("&")
  end

  private

  def self.append_key(root_key, key)
    root_key.nil? ? "#{key}" : "#{root_key}[#{key.to_s}]"
  end
end
