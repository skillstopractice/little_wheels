PKG_FILES = Dir.glob([
  'bin/*',
  'lib/**/*.rb',
  'data/**/*',
  'examples/**/*',
  "LICENSE",
])

Gem::Specification.new do |s|
  s.name        = "little_wheels"
  s.version     = "0.0.3"
  s.summary     = "Little Wheels!"
  s.description = "Potential future implementation of the smallest Rails component library that can possibly work."
  s.authors     = ["Gregory Brown"]
  s.email       = "gregory@practicingdeveloper.com"
  s.files       = PKG_FILES

  s.licenses = ['MIT']
end
