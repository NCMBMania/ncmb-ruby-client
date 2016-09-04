$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'time'
require 'openssl'
require 'base64'
require "net/http"
require "uri"
require "erb"
require "json"

require "ncmb/version"
require "ncmb/client"
require "ncmb/data_store"
require "ncmb/object"
require "ncmb/push"
require "ncmb/geo_point"
require "ncmb/increment"
require "ncmb/error"
