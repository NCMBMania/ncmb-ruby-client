# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'ncmb'
require 'yaml'
yaml = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'setting.yml'))
NCMB.initialize(
  application_key: yaml['application_key'],
  client_key: yaml['client_key']
)

script = NCMB::Script.new 'helloworld.js'
results = script.get
puts results

script = NCMB::Script.new 'helloworld2.js'
results = script.get(query: {a: 'b'})
puts results

script = NCMB::Script.new 'email.js'
results = script.post(body: {email: 'atsushi@moongift.jp', option: 'Test', body: 'message'})
puts results
