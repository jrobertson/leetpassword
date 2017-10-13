Gem::Specification.new do |s|
  s.name = 'leetpassword'
  s.version = '0.2.0'
  s.authors = ['James Robertson']
  s.summary = 'leetpassword creates a password with 1 or 2 random leet words.'
  s.files = Dir['lib/leetpassword.rb']
  s.add_runtime_dependency('random_word', '~> 0.1', '>=0.1.0') 
  s.signing_key = '../privatekeys/leetpassword.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/leetpassword'
  s.required_ruby_version = '>= 2.1.2'
end
