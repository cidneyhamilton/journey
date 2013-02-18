require 'bundler/capistrano'
require 'airbrake/capistrano'

set :application, "journey"
set :scm, :git
set :repository, "https://github.com/nbudin/journey.git"
set :deploy_to, "/var/www/#{application}"

server "popper.sugarpond.net", :app, :web, :db, :primary => true
set :user, "www-data"
set :use_sudo, false

# change this once upgraded to rails 3.1?
set :normalize_asset_timestamps, false

namespace(:deploy) do
  task :symlink_config, :roles => :app do
    %w(database.yml secret_token.yml).each do |config_file|
      run <<-CMD
        ln -nfs #{shared_path}/config/#{config_file} #{release_path}/config/#{config_file}
      CMD
    end
  end
end

after "deploy:update_code", "deploy:symlink_config"
after "deploy", "deploy:cleanup"