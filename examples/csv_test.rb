# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'ncmb'
require 'yaml'
require 'csv'

yaml = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'setting.yml'))
NCMB.initialize(
  application_key: yaml['application_key'],
  client_key: yaml['client_key']
)
@todo = NCMB::DataStore.new 'TestClass'
20.times do |i|
  item = @todo.new
  item.set('message', "Hello! #{i}")
  item.save
end

@todos = @todo.limit(10).skip(0)

csv_string = CSV.generate do |csv|
  csv << @todos.first.fields.keys
  @todos.each do |todo|
    params = []
    todo.fields.keys.each do |name|
      params << todo.call(name)
    end
    csv << params
  end
end

puts csv_string

