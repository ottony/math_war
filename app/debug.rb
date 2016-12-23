module Debug
  def d(msg)
    return if ENV['ENVIRONMENT'].to_s =~ /^test$/i
    puts(msg)
  end
end
