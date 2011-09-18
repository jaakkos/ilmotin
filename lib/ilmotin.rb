require_relative 'ilmotin/options'
require_relative 'ilmotin/clients/base'
require_relative 'ilmotin/clients/hipchat'
require_relative 'ilmotin/clients/campfire'
require_relative 'ilmotin/pill'

module ::Ilmotin
  def self.VERSION
    File.exist?('VERSION') ? File.read('VERSION') : ""
  end
end




