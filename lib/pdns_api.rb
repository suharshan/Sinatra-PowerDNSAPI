require 'rubygems'
require 'sinatra'
require 'sinatra/json'
require 'active_record'

require File.expand_path(File.join(File.dirname(__FILE__), '.', 'config'))

ActiveRecord::Base.establish_connection( 
  :adapter => $adapter,
  :host => $host,
  :username => $username,
  :password => $password,
  :database => $database
)

class Domain < ActiveRecord::Base
  self.table_name = "domains"
  self.inheritance_column = "ruby_type"

  has_many :Records,
    :class_name => "Record"
end

class Record < ActiveRecord::Base
  self.table_name = "records"
  self.inheritance_column = "ruby_type"

  belongs_to :Domain,
    :foreign_key => "domain_id",
    :class_name => "Domain"
end

post '/domain/create' do
  data = JSON.parse(request.body.string)
  if data.nil? then
    status 400
  else
    Domain.create(
      :name => data['name'],
      :type => 'NATIVE'
    )
  end
end

post '/record/create' do
  data = JSON.parse(request.body.string)
  if data.nil? then
    status 400
  else
    Record.create(
      :domain_id => data['domain_id'],
      :name => data['name'],
      :type => data['type'],
      :content => data['content'],
      :ttl => data['ttl']
    )
  end
end

put '/record/:name' do |rName|
  data = JSON.parse(request.body.string)
  record = Record.find_by_name(rName)
  if record.nil? then
    status 404
  else
    record.type = data['type']
    record.content = data['content']
    record.ttl = data['ttl']
    record.save
  end
end

delete '/domain/:name' do |dName|
  if dName.nil? then
    status 400
  else
    domain = Domain.find_by_name(dName)
    if domain.nil? then
      status 404
    else
      domain.destroy
    end
  end
end

delete '/record/:name' do |rName|
  if dName.nil? then
    status 400
  else
    record = Record.find_by_name(dName)
    if record.nil? then
      status 404
    else
      record.destroy
    end
  end
end
