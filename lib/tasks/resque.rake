require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment

#namespace :resque do
#  task :setup do
#    require 'resque'
#    require 'resque-scheduler'
#    require 'resque/scheduler'
#
#    Resque.redis = 'localhost:6379'
    Resque.schedule = YAML.load_file("#{Rails.root}/config/rescue_schedule.yml")
#  end
#end