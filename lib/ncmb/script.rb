# frozen_string_literal: true

module NCMB
  class Script
    include NCMB
    def initialize(name)
      @name = name
      @params = {}
    end
    
    def get(params = {})
      self.set(params).execute('get')
    end
    
    def post(params = {})
      self.set(params).execute('post')
    end
    
    def put(params = {})
      self.set(params).execute('put')
    end
    
    def delete(params = {})
      self.set(params)
      @@client.delete 
    end
    
    def set(params)
      params = Hash[ params.map{ |k, v| [k.to_sym, v] } ]
      self
        .headers(params[:header])
        .body(params[:body])
        .query(params[:query])
      self
    end
    
    def header(params)
      @params[:header] = params
      self
    end
    
    def body(params)
      @params[:body] = params
      self
    end
    
    def query(params)
      @params[:query] = params
      self
    end
    
    def execute(method)
      @@client.send(method, "/#{@@client.script_api_version}/script/#{@name}", (@params[:query] || {}).merge(@params[:body] || {}), @params[:header])
    end
  end
end
