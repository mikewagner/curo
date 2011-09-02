module RSSH

  autoload :Configuration, 'rssh/configuration'
  autoload :Runner,        'rssh/runner'
  autoload :Options,       'rssh/options'
  autoload :Action,        'rssh/action'

  extend self

  def config
    @@config ||= RSSH::Configuration.load
  end


end
