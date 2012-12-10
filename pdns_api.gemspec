Gem::Specification.new do |s|
  s.name              = "pdns_api"
  s.version           = "0.0.1"
  s.description       = "This is an API for PowerDNS server using Sinatra DSL."
  s.summary           = "Easy REST API for PowerDNS using a DSL"
  s.authors           = ["Pubudu Perera"]
  s.email             = "pubudu.perera@senathltd.com"
  s.homepage          = "http://www.senathltd.com/"
  s.files             = ["lib/pdns_api.rb", "lib/config.rb"]

  s.add_dependency 'sinatra',            '~> 1.3.3'
end
