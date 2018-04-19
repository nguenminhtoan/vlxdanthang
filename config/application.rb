require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QLVLXaydung
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.db_host = "localhost"
    config.db_user = "root"
    config.db_pass = "sa2018"
    config.db_schema = "qlvl_xaydung"
    
    
    
    
    config.format_msg = "không đúng định dạng"
    config.blank_msg = "không được trống"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
