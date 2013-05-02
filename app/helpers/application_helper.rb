module ApplicationHelper
  def encodeAddress address
    address.gsub(/\/n/, ' ').gsub(/ /, '+')
  end
end
