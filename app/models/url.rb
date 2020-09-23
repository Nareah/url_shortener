class Url < ActiveRecord::Base
  require 'socket'
  has_many :url_details
  attr_accessor :no_of_visits, :ip_address, :countries

  def create_url_details
    ipaddress = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
    geo = Geocoder.search("72.229.28.185")
    country = geo.first.country
    UrlDetails.create(url_id: self.id, ip_address:ipaddress, country: country)
  end

end
