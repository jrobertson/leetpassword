Gem::Specification.new do |s|
  s.name = 'leetpassword'
  s.version = '0.1.1'
  s.authors = ['James Robertson']
  s.summary = 'leetpassword creates a password with 1 or 2 random leet words.'
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('random-word') 
  s.signing_key = '../privatekeys/leetpassword.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
