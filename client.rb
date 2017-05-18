require 'rubygems'
require 'typhoeus'
require 'json'
require 'user'

class User
  class << self; attr_accessor :base_uri end

  def self.find_by_name(name)
    response = Typhoeus::Request.get(
      "#{base_uri}/api/v1/users/#{name}")
    if response.code == 200
      JSON.parse(response.body)
    elsif response.code == 404
      nil
    else
      raise response.body
    end
  end
  
  def self.create(attributes)
    response = Typhoeus::Request.post(
      "#{base_uri}/api/v1/users",
      :body => attributes.to_json)
    if response.code == 200
      JSON.parse(response.body)
    else
      raise response.body
    end
  end
end