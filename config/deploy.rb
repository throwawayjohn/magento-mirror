set :application, "magento-test"
set :repository,  "git@github.com:throwawayjohn/magento-mirror.git"

set :scm, :git
set :deploy_via, :remote_cache
set :scm_passphrase, "bishkek91"  # The deploy user's password
default_run_options[:pty] = true

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run

set :deploy_to, Dir.pwd

## Non rails
namespace :deploy do
  task :migrate, :roles => :app, :only => { :primary => true } do
    # unset migrate task
  end
  
  task :finalize_update, :except => { :no_release => true } do
    # unset migrate task
    ## run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
  end
end

namespace :mage do
  task :setup, :roles => :app, :except => { :no_release => true } do
    mageSetup = capture("ls -al #{deploy_to}/mage_setup.txt 2> /dev/null | wc -l")
    if mageSetup.match(/^0\s?$/)
      #run "php #{deploy_to}/install.php --license_agreement_accepted 'yes' --locale 'en_GB' --timezone 'Europe/London' --default_currency 'GBP' --db_host 'localhost' --db_name 'magentotest' --db_user 'magentotest' --db_pass 'magentotest' --url 'http://magento-test.zhibek.com' --use_rewrites 'yes' --use_secure 'no' --secure_base_url '' --use_secure_admin 'no' --admin_firstname 'John' --admin_lastname 'Levermore' --admin_email 'john@zhibek.com' --admin_username 'john@zhibek.com' --admin_password 'bishkek91' --skip_url_validation > #{deploy_to}/mage_setup.txt"
      run "php #{current_path}/install.php --license_agreement_accepted 'yes' --locale 'en_GB' --timezone 'Europe/London' --default_currency 'GBP' --db_host 'localhost' --db_name 'magentotest' --db_user 'magentotest' --db_pass 'magentotest' --url 'http://magento-test.zhibek.com' --use_rewrites 'yes' --use_secure 'no' --secure_base_url '' --use_secure_admin 'no' --admin_firstname 'John' --admin_lastname 'Levermore' --admin_email 'john@zhibek.com' --admin_username 'john@zhibek.com' --admin_password 'bishkek91' --skip_url_validation > #{deploy_to}/mage_setup.txt"
    end
  end
end
