set :user, 'deploy'
set :domain, 'myapp.com'
set :application, "myapp"
 
set :repository, "git@github.com:yenism5217/myapp.git"  # Your clone URL
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache
set :scm_passphrase, "umdterpsU1"  # The deploy user's password
set :deploy_to, "/home/#{user}/#{domain}"
set :use_sudo, false
 
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
 
role :web, Nginx                         # Your HTTP server, Apache/etc
role :app, Nginx                          # This may be the same as your `Web` server
role :db,  Nginx, :primary => true # This is where Rails migrations will run
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:migrations", "deploy:cleanup"