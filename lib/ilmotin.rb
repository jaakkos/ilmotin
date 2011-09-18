require 'rubygems'
require 'bluepill'

require 'ilmotin/option_parser'
require 'ilmotin/clients/base'
require 'ilmotin/clients/hipchat'
require 'ilmotin/clients/campfire'
require 'ilmotin/pill'

module ::Ilmotin
  def self.VERSION
    File.exist?('VERSION') ? File.read('VERSION') : ""
  end
end




