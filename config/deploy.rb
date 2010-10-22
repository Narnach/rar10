set :application, "devtunes"
set :repository,  "git@github.com:Narnach/rar10.git"
set :deploy_to,   "/var/rails/devtunes"
set :keep_releases, 10

set :scm, :git
set :deploy_via, "remote_cache"

role :web, "root@rails.govannon.net"                          # Your HTTP server, Apache/etc
role :app, "root@rails.govannon.net"                          # This may be the same as your `Web` server
role :db,  "root@rails.govannon.net", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  desc '[Internal] This is triggered after a succesful deployment. Use it to trigger post-deploy tasks. Triggering on this is easier than triggering in on deploy AND deploy:migrations.'
  task :done do
    # no-op
  end
  after 'deploy', 'deploy:done'
  after 'deploy:migrations', 'deploy:done'

  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :chown do
    run "#{try_sudo} chown -R www-data:root #{deploy_to}"
  end
  after 'deploy:setup', 'deploy:chown'

  task :chown_deployment do
    run "#{try_sudo} chown -R www-data:root #{current_release}"
  end
  after 'deploy:update_code', 'deploy:chown_deployment'

  desc 'Create a symlink for shared config files.'
  task :symlink_config do
    %w[config/database.yml config/lastfm.yml].each do |file|
      run "ln -sf #{shared_path}/#{file} #{latest_release}/#{file}"
    end
  end

  desc 'Chmod 777 the javascripts dir'
  task :chmod_javascripts do
    run "chmod 777 #{latest_release}/public/javascripts"
  end
  after "deploy:done", "deploy:chmod_javascripts"

  task :notify_irc do
    run "cd #{latest_release} && git log --pretty=format:'devtunes : %ar, %an: %s' #{previous_revision}..#{latest_revision} | grep -v Merge| sed -e s/Wes\\ Oldenbeuving/narnach/ > /tmp/to_irc/#{Time.now.to_f}.txt"
  end

  after 'deploy:update_code', 'deploy:symlink_config'

  after 'deploy:done', 'deploy:cleanup', "deploy:notify_irc"
end


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
