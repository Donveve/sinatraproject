 require './config/environment'
#
#
# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end
#
#
# use Rack::MethodOverride
# use StudentsController
# use TeachersController
# run ApplicationController
require_relative 'app/controllers/application_controller.rb'

# use Rack::Static, urls: ['/css'], root: 'public' # Rack fix allows seeing the css folder.

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end
use Rack::MethodOverride

use TeachersController
use StudentsController
run ApplicationController
