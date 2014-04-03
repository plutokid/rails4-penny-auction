module MainHelper
  def int_from_decimal(dec)
    dec.to_int
  end

  def fractional_from_decimal(dec)
    parts   = dec.to_s.split(".")
    number  = parts.count > 1 ? parts[1].to_s : 0
    number = "0#{number}" if number.to_i < 10
    number
  end
end
